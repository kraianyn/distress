import 'package:distress/src/domain/entities/course_type.dart';

import '../types.dart';
import 'entity.dart';


class CourseTypeModel extends CourseType implements EntityModel {
	CourseTypeModel.fromEntry(EntityEntry entry) : super(
		id: entry.key,
		name: entry.value[Field.name] as String
	);

	CourseTypeModel.fromEntity(CourseType entity) : super(
		id: entity.id,
		name: entity.name
	);

	@override
	ObjectMap get object => {
		Field.name: name
	};
}
