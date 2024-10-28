import 'package:distress/src/domain/entities/course_type.dart';

import '../types.dart';


/// `id: {
/// 	name: String,
/// 	courseCount: int,
/// 	studentCount: int
/// }`
extension CourseTypeModel on CourseType {
	static CourseType fromEntry(EntityEntry entry) => CourseType(
		id: entry.key,
		name: entry.value[Field.name] as String,
		courseCount: entry.value[Field.courseCount] as int,
		studentCount: entry.value[Field.studentCount] as int
	);

	ObjectMap toObject() => {
		Field.name: name,
		Field.courseCount: courseCount,
		Field.studentCount: studentCount
	};
}
