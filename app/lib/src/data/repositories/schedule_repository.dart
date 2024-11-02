import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/entity.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import '../types.dart';
import '../models/course.dart';
import '../models/course_type.dart';
import '../models/instructor.dart';
import '../models/location.dart';


class ScheduleRepository {
	Future<List<Course>>? _coursesFuture;
	Future<List<CourseType>>? _courseTypesFuture;
	Future<List<Location>>? _locationsFuture;
	Future<List<Instructor>>? _instructorsFuture;

	Future<List<Course>> courses() async {
		_coursesFuture ??= _courses();
		return _coursesFuture!;
	}

	Future<List<Course>> _courses() async {
		final dataFuture = _EntitiesDocument.courses.data();
		final typesFuture = courseTypes();
		final instructorsFuture = this.instructors();
		final locationsFuture = this.locations();

		final data = await dataFuture;
		final types = await typesFuture;
		final instructors = await instructorsFuture;
		final locations = await locationsFuture;

		return data.entries.map<Course>((entry) => CourseModel.fromEntry(
			entry,
			allTypes: types,
			allInstructors: instructors,
			allLocations: locations
		)).toList();
	}

	Future<void> addCourse(Course course) async {
		await _EntitiesDocument.courses.reference.setEntity(course, course.toObject());
	}

	Future<FinishedCourse> finishCourse(Course course, {required int studentCount}) async {
		final typeId = course.type.id;
		await _EntitiesDocument.courseTypes.reference.update({
			'$typeId.${Field.courseCount}': FieldValue.increment(1),
			'$typeId.${Field.studentCount}': FieldValue.increment(studentCount)
		});
		final types = await courseTypes(useCache: false);
		final type = types.firstWhere((t) => t == course.type);
		final finishedCourse = course.finished(
			number: type.courseCount,
			studentCount: studentCount,
			firstCertificateNumber: type.certificatesAreIssuedByTrainingCenter
				? type.studentCount - studentCount + 1
				: null
		);

		final scheduleDocument = _EntitiesDocument.courses.reference.collection('archive').doc(
			finishedCourse.scheduleId
		);
		final scheduleDocumentExists = (await scheduleDocument.get()).exists;
		final scheduleDocumentData = {
			finishedCourse.id: finishedCourse.toObject()
		};
		await Future.wait([
			scheduleDocumentExists
				? scheduleDocument.update(scheduleDocumentData)
				: scheduleDocument.set(scheduleDocumentData),
			_EntitiesDocument.courses.reference.deleteEntity(finishedCourse)
		]);

		return finishedCourse;
	}

	Future<void> updateCourse(Course course) async {
		await _EntitiesDocument.courses.reference.setEntity(course, course.toObject());
	}

	Future<void> deleteCourse(Course course) async {
		await _EntitiesDocument.courses.reference.deleteEntity(course);
	}

	Future<void> deleteCoursesWithType(CourseType type) =>
		_deleteCoursesWithEntity(type, Field.type);

	Future<void> deleteCoursesWithLocation(Location location) =>
		_deleteCoursesWithEntity(location, Field.location);

	Future<void> _deleteCoursesWithEntity(Entity entity, String field) async {
		final coursesData = await _EntitiesDocument.courses.data();
		final entityCoursesEntries = coursesData.entries.where(
			(entry) => entry.value[field] == entity.id
		).toList();
		if (entityCoursesEntries.isNotEmpty) {
			await _EntitiesDocument.courses.reference.update({
				for(final entry in entityCoursesEntries)
					entry.key: FieldValue.delete()
			});
		}
	}

	Future<List<CourseType>> courseTypes({bool useCache = true}) async {
		if (!useCache || _courseTypesFuture == null) {
			_courseTypesFuture = _simpleEntities(
				_EntitiesDocument.courseTypes,
				CourseTypeModel.fromEntry
			);
		}
		return _courseTypesFuture!;
	}

	Future<void> addCourseType(CourseType type) async {
		await _EntitiesDocument.courseTypes.reference.setEntity(type, type.toObject());
	}

	Future<void> updateCourseType(CourseType type) async {
		await _EntitiesDocument.courseTypes.reference.setEntity(type, type.toObject());
	}

	Future<void> deleteCourseType(CourseType type) =>
		_EntitiesDocument.courseTypes.reference.deleteEntity(type);

	Future<List<Instructor>> instructors() async {
		_instructorsFuture ??= _simpleEntities(
			_EntitiesDocument.instructors,
			InstructorModel.fromEntry
		);
		return _instructorsFuture!;
	}

	Future<void> addInstructor(Instructor instructor) async {
		await _EntitiesDocument.instructors.reference.setEntity(instructor, instructor.toObject());
	}

	Future<List<Location>> locations() async {
		_locationsFuture ??= _simpleEntities(
			_EntitiesDocument.locations,
			LocationModel.fromEntry
		);
		return _locationsFuture!;
	}

	Future<void> addLocation(Location location) async {
		await _EntitiesDocument.locations.reference.setEntity(location, location.toObject());
	}

	Future<void> updateLocation(Location location) async {
		await _EntitiesDocument.locations.reference.setEntity(location, location.toObject());
	}

	Future<void> deleteLocation(Location location) =>
		_EntitiesDocument.locations.reference.deleteEntity(location);

	Future<List<E>> _simpleEntities<E>(
		_EntitiesDocument document,
		E Function(EntityEntry) constructor
	) async {
		final data = await document.data();
		return data.entries.map<E>(constructor).toList();
	}
}

enum _EntitiesDocument {
	courses,
	courseTypes,
	instructors,
	locations;

	DocumentReference<ObjectMap> get reference =>
		FirebaseFirestore.instance.doc('schedule/$name');
	
	Future<_DocumentMap> data() async {
		final snapshot = await reference.get();
		return _DocumentMap.from(snapshot.data()!);
	}
}

extension on DocumentReference {
	Future<void> setEntity(Entity entity, ObjectMap object) => update({
		entity.id: object
	});

	Future<void> deleteEntity(Entity entity) => update({
		entity.id: FieldValue.delete()
	});
}

typedef _DocumentMap = Map<String, ObjectMap>;
