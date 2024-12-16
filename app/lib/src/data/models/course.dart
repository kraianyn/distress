import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import '../types.dart';


/// `id: {
/// 	type: String,
/// 	date: Timestamp,
/// 	location: String,
/// 	instructors: List<String>,
/// 	leadInstructor: String?,
/// 	note?: String,
/// 	number?: int,
/// 	studentCount?: int,
/// 	firstCertificateNumber?: int
/// }`
extension CourseModel on Course {
	static Course fromEntry(
		EntityEntry entry, {
			required List<CourseType> allTypes,
			required List<Location> allLocations,
			required List<Instructor> allInstructors
	}) {
		final id = entry.key;
		final type = allTypes.firstWhere((t) => t.id == entry.value[Field.type]);
		final date = (entry.value[Field.date] as Timestamp).toDate();
		final location = allLocations.firstWhere((l) => l.id == entry.value[Field.location]);

		final instructorIds = List<String>.from(entry.value[Field.instructors]);
		final instructors = allInstructors.where((i) => instructorIds.contains(i.id)).toList();

		final leadInstructorId = entry.value[Field.leadInstructor] as String?;
		final leadInstructor = leadInstructorId != null
			? instructors.firstWhere((i) => i.id == leadInstructorId)
			: null;
		
		final note = entry.value[Field.note] as String?;

		if (!entry.value.containsKey(Field.number)) {
			return Course(
				id: id,
				type: type,
				date: date,
				location: location,
				instructors: instructors,
				leadInstructor: leadInstructor,
				note: note
			);
		}
		return FinishedCourse(
			id: id,
			type: type,
			date: date,
			location: location,
			instructors: instructors,
			leadInstructor: leadInstructor,
			note: note,
			number: entry.value[Field.number] as int,
			studentCount: entry.value[Field.studentCount] as int,
			firstCertificateNumber: entry.value[Field.firstCertificateNumber] as int?
		);
	}

	ObjectMap toObject() {
		final object = {
			Field.type: type.id,
			Field.date: Timestamp.fromDate(date),
			Field.location: location.id,
			Field.instructors: instructors.map((i) => i.id),
			Field.leadInstructor: leadInstructor?.id,
			if (note != null) Field.note: note
		};
		if (this is! FinishedCourse) return object;
		
		final course = this as FinishedCourse;
		return {
			...object,
			Field.number: course.number,
			Field.studentCount: course.studentCount,
			if (course.firstCertificateNumber != null)
				Field.firstCertificateNumber: course.firstCertificateNumber
		};
	}

	String get scheduleId => '${date.year}-${date.month}';
}
