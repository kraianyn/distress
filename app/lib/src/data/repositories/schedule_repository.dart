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
import '../models/entity.dart';
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
		final dataFuture = _Document.courses.data();
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

	Future<List<CourseType>> courseTypes() async {
		_courseTypesFuture ??= _simpleEntities(
			_Document.courseTypes,
			CourseTypeModel.fromEntry
		);
		return _courseTypesFuture!;
	}

	Future<List<Location>> locations() async {
		_locationsFuture ??= _simpleEntities(
			_Document.locations,
			LocationModel.fromEntry
		);
		return _locationsFuture!;
	}

	Future<List<Instructor>> instructors() async {
		_instructorsFuture ??= _simpleEntities(
			_Document.instructors,
			InstructorModel.fromEntry
		);
		return _instructorsFuture!;
	}

	Future<List<E>> _simpleEntities<E>(
		_Document document,
		E Function(EntityEntry) constructor
	) async {
		final data = await document.data();
		return data.entries.map<E>(constructor).toList();
	}

	Future<void> addCourse(Course course) => _Document.courses.update(
		CourseModel.fromEntity(course)
	);

	Future<void> addCourseType(CourseType type) => _Document.courseTypes.update(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> addInstructor(Instructor instructor) => _Document.instructors.update(
		InstructorModel.fromEntity(instructor)
	);

	Future<void> addLocation(Location location) => _Document.locations.update(
		LocationModel.fromEntity(location)
	);

	Future<void> updateCourse(Course course) => _Document.courses.update(
		CourseModel.fromEntity(course)
	);

	Future<void> updateCourseType(CourseType type) => _Document.courseTypes.update(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> updateLocation(Location type) => _Document.locations.update(
		LocationModel.fromEntity(type)
	);

	Future<void> deleteCourse(Course course) => _Document.courses.delete(
		CourseModel.fromEntity(course)
	);

	Future<void> deleteCoursesWithType(CourseType type) =>
		_deleteCoursesWithEntity(type, Field.type);

	Future<void> deleteCoursesWithLocation(Location location) =>
		_deleteCoursesWithEntity(location, Field.location);

	Future<void> _deleteCoursesWithEntity(Entity entity, String field) async {
		final coursesDocument = await _Document.courses.data();
		final entityCoursesEntries = coursesDocument.entries.where(
			(entry) => entry.value[field] == entity.id
		);
		if (entityCoursesEntries.isNotEmpty) {
			await _Document.courses.ref.update({
				for(final entry in entityCoursesEntries)
					entry.key: FieldValue.delete()
			});
		}
	}

	Future<void> removeInstructorFromCourses(Instructor instructor) async {
		final coursesDocument = await _Document.courses.data();

		final updatedCourses = <String, List<String>>{};
		for (final entry in coursesDocument.entries) {
			final instructors = List<String>.from(entry.value[Field.instructors]);
			if (instructors.contains(instructor.id)) {
				final key = '${entry.key}.${Field.instructors}';
				updatedCourses[key] = instructors..remove(instructor.id);
			}
		}
		if (updatedCourses.isNotEmpty) {
			await _Document.courses.ref.update(updatedCourses);
		}
	}

	Future<void> deleteCourseType(CourseType type) => _Document.courseTypes.delete(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> deleteInstructor(Instructor instructor) => _Document.instructors.delete(
		InstructorModel.fromEntity(instructor)
	);

	Future<void> deleteLocation(Location type) => _Document.locations.delete(
		LocationModel.fromEntity(type)
	);
}

enum _Document {
	courses,
	courseTypes,
	instructors,
	locations;

	Future<_DocumentMap> data() async {
		final snapshot = await ref.get();
		return _DocumentMap.from(snapshot.data()!);
	}

	Future<void> update(EntityModel model) async {
		await ref.update({
			model.id: model.object
		});
	}

	Future<void> delete(EntityModel model) async {
		await ref.update({
			model.id: FieldValue.delete()
		});
	}

	DocumentReference<ObjectMap> get ref =>
		FirebaseFirestore.instance.collection('schedule').doc(name);
}

typedef _DocumentMap = Map<String, ObjectMap>;
