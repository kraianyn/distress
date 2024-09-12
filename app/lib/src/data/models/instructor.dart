import 'package:distress/src/domain/instructor.dart';

import '../types.dart';
import 'entity.dart';


class InstructorModel extends Instructor implements EntityModel {
	const InstructorModel({
		required super.id,
		required super.codeName
	});

	InstructorModel.fromEntry(EntityEntry entry) : this(
		id: entry.key,
		codeName: entry.value[Field.codeName] as String
	);

	InstructorModel.fromEntity(Instructor entity) : this(
		id: entity.id,
		codeName: entity.codeName
	);

	@override
	ObjectMap get object => {
		Field.codeName: codeName
	};
}
