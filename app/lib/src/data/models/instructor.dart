import 'package:distress/src/domain/instructor.dart';

import '../field.dart';
import '../types.dart';
import 'entity.dart';


class InstructorModel extends Instructor implements EntityModel {
	const InstructorModel({
		required super.id,
		required super.codeName
	});

	InstructorModel.fromEntry(MapEntry<String, ObjectMap> entry) : this(
		id: entry.key,
		codeName: entry.value[Field.codeName] as String
	);

	InstructorModel.fromEntity(Instructor entity) : this(
		id: entity.id,
		codeName: entity.codeName
	);

	@override
	MapEntry<String, ObjectMap> get entry => MapEntry(id, {
		Field.codeName: codeName
	});
}
