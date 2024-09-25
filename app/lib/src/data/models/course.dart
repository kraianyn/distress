import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import '../types.dart';
import 'entity.dart';


/// `id: {
/// 	type: String,
///     date: Timestamp,
/// 	location: String,
/// 	instructors: List<String>
/// }`
class CourseModel extends Course implements EntityModel {
	const CourseModel({
		required super.id,
		required super.type,
		required super.date,
		required super.location,
		required super.instructors,
		required super.leadInstructor,
		super.note
	});

	factory CourseModel.fromEntry(
		EntityEntry entry, {
			required List<CourseType> types,
			required List<Location> locations,
			required List<Instructor> instructors
	}) {
		final typeId = entry.value[Field.type] as String;
		final timestamp = entry.value[Field.date] as Timestamp;
		final locationId = entry.value[Field.location] as String;
		final instructorsIds = List<String>.from(entry.value[Field.instructors]);
		final leadInstructorId = entry.value[Field.leadInstructor] as String?;

		return CourseModel(
			id: entry.key,
			type: types.firstWhere((t) => t.id == typeId),
			date: timestamp.toDate(),
			location: locations.firstWhere((l) => l.id == locationId),
			instructors: instructors.where((i) => instructorsIds.contains(i.id)).toList(),
			leadInstructor: leadInstructorId != null
				? instructors.firstWhere((i) => i.id == leadInstructorId)
				: null,
			note: entry.value[Field.note] as String?
		);
	}

	CourseModel.fromEntity(Course entity) : super(
		id: entity.id,
		type: entity.type,
		date: entity.date,
		location: entity.location,
		instructors: entity.instructors,
		leadInstructor: entity.leadInstructor,
		note: entity.note
	);

	@override
	ObjectMap get object => {
		Field.type: type.id,
		Field.date: Timestamp.fromDate(date),
		Field.location: location.id,
		Field.instructors: instructors.map((i) => i.id),
		Field.leadInstructor: leadInstructor?.id,
		if (note != null) Field.note: note
	};
}
