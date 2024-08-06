import 'package:distress/src/domain/course_type.dart';

import '../field.dart';
import '../types.dart';


class CourseTypeModel extends CourseType {
	const CourseTypeModel({
		required super.id,
		required super.name
	});

	CourseTypeModel.fromEntry(MapEntry<String, ObjectMap> entry) : this(
		id: entry.key,
		name: entry.value[Field.name] as String
	);

	CourseTypeModel.fromEntity(CourseType type) : this(
		id: type.id,
		name: type.name
	);

	MapEntry<String, ObjectMap> get entry => MapEntry(id, {
		Field.name: name
	});
}
