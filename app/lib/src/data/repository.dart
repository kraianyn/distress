import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/course_type.dart';
import 'package:distress/src/domain/entity.dart';
import 'package:distress/src/domain/instructor.dart';
import 'package:distress/src/domain/location.dart';

import 'field.dart';
import 'types.dart';

import 'models/course.dart';
import 'models/course_type.dart';
import 'models/entity.dart';
import 'models/instructor.dart';
import 'models/location.dart';


class Repository {
	Future<List<Course>>? _coursesFuture;
	Future<List<CourseType>>? _courseTypesFuture;
	Future<List<Location>>? _locationsFuture;
	Future<List<Instructor>>? _instructorsFuture;

	Future<List<Course>> courses() async {
		_coursesFuture ??= _courses();
		return _coursesFuture!;
	}

	Future<List<Course>> _courses() async {
		final dataFuture = Document.courses.data();
		final typesFuture = courseTypes();
		final instructorsFuture = this.instructors();
		final locationsFuture = this.locations();

		final data = await dataFuture;
		final types = await typesFuture;
		final instructors = await instructorsFuture;
		final locations = await locationsFuture;

		return data.entries.map<Course>((entry) => CourseModel.fromEntry(
			entry,
			types: types,
			instructors: instructors,
			locations: locations
		)).toList();
	}

	Future<List<CourseType>> courseTypes() async {
		_courseTypesFuture ??= _courseTypes();
		return _courseTypesFuture!;
	}

	Future<List<CourseType>> _courseTypes() =>
		_simpleEntities(Document.courseTypes, CourseTypeModel.fromEntry);

	Future<List<Location>> locations() async {
		_locationsFuture ??= _locations();
		return _locationsFuture!;
	}

	Future<List<Location>> _locations() =>
		_simpleEntities(Document.locations, LocationModel.fromEntry);

	Future<List<Instructor>> instructors() async {
		_instructorsFuture ??= _instructors();
		return _instructorsFuture!;
	}

	Future<List<Instructor>> _instructors() =>
		_simpleEntities(Document.instructors, InstructorModel.fromEntry);

	Future<List<E>> _simpleEntities<E>(
		Document document,
		E Function(DocumentEntry) constructor
	) async {
		final data = await document.data();
		return data.entries.map<E>(constructor).toList();
	}

	Future<void> addCourse(Course course) => Document.courses.update(
		CourseModel.fromEntity(course)
	);

	Future<void> addCourseType(CourseType type) => Document.courseTypes.update(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> addInstructor(Instructor instructor) => Document.instructors.update(
		InstructorModel.fromEntity(instructor)
	);

	Future<void> addLocation(Location location) => Document.locations.update(
		LocationModel.fromEntity(location)
	);

	Future<void> updateCourseType(CourseType type) => Document.courseTypes.update(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> deleteCourse(Course course) => Document.courses.delete(
		CourseModel.fromEntity(course)
	);

	Future<void> deleteCoursesWithType(CourseType type) =>
		_deleteCoursesWithEntity(type, Field.type);

	Future<void> deleteCoursesWithLocation(Location location) =>
		_deleteCoursesWithEntity(location, Field.location);

	Future<void> _deleteCoursesWithEntity(Entity entity, String field) async {
		final coursesDocument = await Document.courses.data();
		final entityCoursesEntries = coursesDocument.entries.where(
			(entry) => entry.value[field] == entity.id
		);
		if (entityCoursesEntries.isNotEmpty) {
			await Document.courses.ref.update({
				for(final entry in entityCoursesEntries)
					entry.key: FieldValue.delete()
			});
		}
	}

	Future<void> removeInstructorFromCourses(Instructor instructor) async {
		final coursesDocument = await Document.courses.data();

		final updatedCourses = <String, List<String>>{};
		for (final entry in coursesDocument.entries) {
			final instructors = List<String>.from(entry.value[Field.instructors]);
			if (instructors.contains(instructor.id)) {
				final key = '${entry.key}.${Field.instructors}';
				updatedCourses[key] = instructors..remove(instructor.id);
			}
		}
		if (updatedCourses.isNotEmpty) {
			await Document.courses.ref.update(updatedCourses);
		}
	}

	Future<void> deleteCourseType(CourseType type) => Document.courseTypes.delete(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> deleteLocation(Location type) => Document.locations.delete(
		LocationModel.fromEntity(type)
	);

	Future<void> deleteInstructor(Instructor instructor) => Document.instructors.delete(
		InstructorModel.fromEntity(instructor)
	);
}

enum Document {
	/// `id: {
	/// 	type: String,
	///     date: Timestamp,
	/// 	location: String,
	/// 	instructors: List<String>
	/// }, ...`
	courses,

	/// `id: {
	/// 	name: String
	/// }, ...`
	courseTypes,

	/// `id: {
	/// 	codeName: String
	/// }, ...`
	instructors,

	/// `id: {
	/// 	name: String,
	/// 	link: string
	/// }, ...`
	locations;

	Future<DocumentMap> data() async {
		final snapshot = await ref.get();
		return DocumentMap.from(snapshot.data() as ObjectMap);
	}

	Future<void> update(EntityModel model) async {
		final entry = model.entry;
		await ref.update({
			entry.key: entry.value
		});
	}

	Future<void> delete(EntityModel model) async {
		await ref.update({
			model.entry.key: FieldValue.delete()
		});
	}

	DocumentReference get ref =>
		FirebaseFirestore.instance.collection('data').doc(name);
}
