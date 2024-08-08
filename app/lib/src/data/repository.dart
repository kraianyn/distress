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
	List<Course>? _courses;
	List<CourseType>? _courseTypes;
	List<Location>? _locations;
	List<Instructor>? _instructors;

	Future<List<Course>> courses() async {
		if (_courses != null) return _courses!;

		final dataFuture = Document.courses.data();
		final typesFuture = courseTypes();
		final instructorsFuture = this.instructors();
		final locationsFuture = this.locations();

		final data = await dataFuture;
		final types = await typesFuture;
		final instructors = await instructorsFuture;
		final locations = await locationsFuture;

		_courses = data.entries.map((entry) => CourseModel.fromEntry(
			entry,
			types: types,
			instructors: instructors,
			locations: locations
		)).toList();
		return _courses!;
	}

	Future<List<CourseType>> courseTypes() async {
		if (_courseTypes != null) return _courseTypes!;

		final data = await Document.courseTypes.data();
		_courseTypes = data.entries.map(CourseTypeModel.fromEntry).toList();
		return _courseTypes!;
	}

	Future<List<Location>> locations() async {
		if (_locations != null) return _locations!;

		final data = await Document.locations.data();
		_locations = data.entries.map(LocationModel.fromEntry).toList();
		return _locations!;
	}

	Future<List<Instructor>> instructors() async {
		if (_instructors != null) return _instructors!;

		final data = await Document.instructors.data();
		_instructors = data.entries.map(InstructorModel.fromEntry).toList();
		return _instructors!;
	}

	Future<void> addCourse(Course course) => Document.courses.add(
		CourseModel.fromEntity(course)
	);

	Future<void> addCourseType(CourseType type) => Document.courseTypes.add(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> addInstructor(Instructor instructor) => Document.instructors.add(
		InstructorModel.fromEntity(instructor)
	);

	Future<void> addLocation(Location location) => Document.locations.add(
		LocationModel.fromEntity(location)
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
		await Document.courses._ref.update({
			for(final entry in entityCoursesEntries)
				entry.key: FieldValue.delete()
		});
	}

	Future<void> deleteCourseType(CourseType type) => Document.courseTypes.delete(
		CourseTypeModel.fromEntity(type)
	);

	Future<void> deleteLocation(Location type) => Document.locations.delete(
		LocationModel.fromEntity(type)
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
		final snapshot = await _ref.get();
		return DocumentMap.from(snapshot.data() as ObjectMap);
	}

	Future<void> add(EntityModel model) async {
		final entry = model.entry;
		await _ref.update({
			entry.key: entry.value
		});
	}

	Future<void> delete(EntityModel model) async {
		await _ref.update({
			model.entry.key: FieldValue.delete()
		});
	}

	DocumentReference get _ref =>
		FirebaseFirestore.instance.collection('data').doc(name);
}
