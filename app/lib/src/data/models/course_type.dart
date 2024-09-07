import 'package:distress/src/domain/course_type.dart';

import '../field.dart';
import '../schedule_repository.dart';

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
	ObjectMap get object => {
		Field.name: name
	};
}
