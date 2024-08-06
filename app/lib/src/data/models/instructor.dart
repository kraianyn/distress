import 'package:distress/src/domain/instructor.dart';

import '../field.dart';
import '../types.dart';


class InstructorModel extends Instructor {
	const InstructorModel({
		required super.id,
		required super.codeName
	});

	InstructorModel.fromEntry(MapEntry<String, ObjectMap> entry) : this(
		id: entry.key,
		codeName: entry.value[Field.codeName] as String
	);

	InstructorModel.fromEntity(Instructor type) : this(
		id: type.id,
		codeName: type.codeName
	);

	MapEntry<String, ObjectMap> get entry => MapEntry(id, {
		Field.codeName: codeName
	});
}
