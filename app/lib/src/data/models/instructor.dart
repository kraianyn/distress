import 'package:distress/src/domain/instructor.dart';

import '../field.dart';
import '../schedule_repository.dart';

import 'entity.dart';


class InstructorModel extends Instructor implements EntityModel {
	const InstructorModel({
		required super.id,
		required super.codeName
	});

	InstructorModel.fromEntry(DocumentEntry entry) : this(
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
