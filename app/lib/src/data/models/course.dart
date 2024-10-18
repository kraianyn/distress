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
/// 	instructors: List<String>,
/// 	leadInstructor: String?
/// 	note?: String,
/// 	studentCount?: int
/// }`
class CourseModel extends Course implements EntityModel {
	const CourseModel({
		required super.id,
		required super.type,
		required super.date,
		required super.location,
		required super.instructors,
		required super.leadInstructor,
		super.note,
		super.studentCount
	});

	factory CourseModel.fromEntry(
		EntityEntry entry, {
			required List<CourseType> allTypes,
			required List<Location> allLocations,
			required List<Instructor> allInstructors
	}) {
		final typeId = entry.value[Field.type] as String;
		final locationId = entry.value[Field.location] as String;
		final instructorIds = List<String>.from(entry.value[Field.instructors]);
		final instructors = allInstructors.where(
			(i) => instructorIds.contains(i.id)
		).toList();
		final leadInstructorId = entry.value[Field.leadInstructor] as String?;

		return CourseModel(
			id: entry.key,
			type: allTypes.firstWhere((t) => t.id == typeId),
			date: (entry.value[Field.date] as Timestamp).toDate(),
			location: allLocations.firstWhere((l) => l.id == locationId),
			instructors: instructors,
			leadInstructor: leadInstructorId != null
				? instructors.firstWhere((i) => i.id == leadInstructorId)
				: null,
			note: entry.value[Field.note] as String?,
			studentCount: entry.value[Field.studentCount] as int?
		);
	}

	CourseModel.fromEntity(Course entity) : super(
		id: entity.id,
		type: entity.type,
		date: entity.date,
		location: entity.location,
		instructors: entity.instructors,
		leadInstructor: entity.leadInstructor,
		note: entity.note,
		studentCount: entity.studentCount
	);

	@override
	ObjectMap get object => {
		Field.type: type.id,
		Field.date: Timestamp.fromDate(date),
		Field.location: location.id,
		Field.instructors: instructors.map((i) => i.id),
		Field.leadInstructor: leadInstructor?.id,
		if (note != null) Field.note: note,
		if (studentCount != null) Field.studentCount: studentCount
	};
}
