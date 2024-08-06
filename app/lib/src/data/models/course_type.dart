import 'package:distress/src/domain/course_type.dart';

import '../field.dart';
import '../types.dart';
import 'entity.dart';


class CourseTypeModel extends CourseType implements EntityModel {
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

	@override
	MapEntry<String, ObjectMap> get entry => MapEntry(id, {
		Field.name: name
	});
}
