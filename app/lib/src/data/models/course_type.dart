import 'package:distress/src/domain/course_type.dart';

import '../field.dart';
import '../types.dart';
import 'entity.dart';


class CourseTypeModel extends CourseType implements EntityModel {
	const CourseTypeModel({
		required super.id,
		required super.name
	});

	CourseTypeModel.fromEntry(DocumentEntry entry) : this(
		id: entry.key,
		name: entry.value[Field.name] as String
	);

	CourseTypeModel.fromEntity(CourseType entity) : this(
		id: entity.id,
		name: entity.name
	);

	@override
	DocumentEntry get entry => MapEntry(id, {
		Field.name: name
	});
}
