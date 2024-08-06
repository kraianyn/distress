import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/course_type.dart';
import 'package:distress/src/domain/instructor.dart';
import 'package:distress/src/domain/location.dart';

import '../field.dart';
import '../types.dart';
import 'entity.dart';


class CourseModel extends Course implements EntityModel {
	const CourseModel({
		required super.id,
		required super.type,
		required super.date,
		required super.location,
		required super.instructors
	});

	factory CourseModel.fromEntry(
		MapEntry<String, ObjectMap> entry, {
			required List<CourseType> types,
			required List<Location> locations,
			required List<Instructor> instructors
	}) {
		final typeId = entry.value[Field.type] as String;
		final timestamp = entry.value[Field.date] as Timestamp;
		final locationId = entry.value[Field.location] as String;
		final instructorIds = List<String>.from(entry.value[Field.instructors]);

		return CourseModel(
			id: entry.key,
			type: types.firstWhere((t) => t.id == typeId),
			date: timestamp.toDate(),
			location: locations.firstWhere((l) => l.id == locationId),
			instructors: instructors.where((i) => instructorIds.contains(i.id)).toList()
		);
	}

	CourseModel.fromEntity(Course entity) : this(
		id: entity.id,
		type: entity.type,
		date: entity.date,
		location: entity.location,
		instructors: entity.instructors
	);

	@override
	MapEntry<String, ObjectMap> get entry => MapEntry(id, {
		Field.type: type.id,
		Field.date: date,
		Field.location: location.id,
		Field.instructors: instructors.map((i) => i.id)
	});
}
