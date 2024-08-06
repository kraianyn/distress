import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/course_type.dart';
import 'package:distress/src/domain/instructor.dart';
import 'package:distress/src/domain/location.dart';

import 'types.dart';
import 'models/course.dart';
import 'models/course_type.dart';
import 'models/instructor.dart';
import 'models/location.dart';


class Repository {
	List<Course>? _courses;
	List<CourseType>? _courseTypes;
	List<Location>? _locations;
	List<Instructor>? _instructors;

	Future<List<Course>> courses() async {
		if (_courses != null) return _courses!;

		final snapshotFuture = Document.courses.ref.get();
		final courseTypesFuture = this.courseTypes();
		final instructorsFuture = this.instructors();
		final locationsFuture = this.locations();

		final snapshot = await snapshotFuture;
		final courseTypes = await courseTypesFuture;
		final instructors = await instructorsFuture;
		final locations = await locationsFuture;

		final data = DocumentMap.from(snapshot.data() as ObjectMap);
		_courses = data.entries.map((entry) => CourseModel.fromCloudFormat(
			id: entry.key,
			object: entry.value,
			types: courseTypes,
			instructors: instructors,
			locations: locations
		)).toList();
		return _courses!;
	}

	Future<List<CourseType>> courseTypes() async {
		if (_courseTypes != null) return _courseTypes!;

		final snapshot = await Document.courseTypes.ref.get();
		final data = DocumentMap.from(snapshot.data() as ObjectMap);

		_courseTypes = data.entries.map((entry) => CourseTypeModel.fromCloudFormat(
			id: entry.key,
			object: entry.value
		)).toList();
		return _courseTypes!;
	}

	Future<List<Location>> locations() async {
		if (_locations != null) return _locations!;

		final snapshot = await Document.locations.ref.get();
		final data = DocumentMap.from(snapshot.data() as ObjectMap);

		_locations = data.entries.map((entry) => LocationModel.fromCloudFormat(
			id: entry.key,
			object: entry.value
		)).toList();
		return _locations!;
	}

	Future<List<Instructor>> instructors() async {
		if (_instructors != null) return _instructors!;

		final snapshot = await Document.instructors.ref.get();
		final data = DocumentMap.from(snapshot.data() as ObjectMap);

		_instructors = data.entries.map((entry) => InstructorModel.fromCloudFormat(
			id: entry.key,
			object: entry.value
		)).toList();
		return _instructors!;
	}
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

	DocumentReference get ref =>
		FirebaseFirestore.instance.collection('data').doc(name);
}
