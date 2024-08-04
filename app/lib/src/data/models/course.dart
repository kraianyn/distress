import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/course_type.dart';
import 'package:distress/src/domain/instructor.dart';
import 'package:distress/src/domain/location.dart';

import '../field.dart';


class CourseModel extends Course {
	const CourseModel({
		required super.id,
		required super.type,
		required super.date,
		required super.location,
		required super.instructors
	});

	factory CourseModel.fromCloudFormat({
		required String id,
		required Map<String, dynamic> object,
		required List<CourseType> types,
		required List<Location> locations,
		required List<Instructor> instructors
	}) {
		final typeId = object[Field.type] as String;
		final locationId = object[Field.location] as String;
		final instructorIds = List<String>.from(object[Field.instructors]);

		return CourseModel(
			id: id,
			type: types.firstWhere((t) => t.id == typeId),
			date: (object[Field.date] as Timestamp).toDate(),
			location: locations.firstWhere((l) => l.id == locationId),
			instructors: instructors.where((i) => instructorIds.contains(i.id)).toList()
		);
	}
}
