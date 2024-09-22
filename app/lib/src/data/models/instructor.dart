import 'package:distress/src/domain/entities/instructor.dart';

import '../types.dart';
import 'entity.dart';


/// `id: {
/// 	codeName: String
/// }`
class InstructorModel extends Instructor implements EntityModel {
	InstructorModel.fromEntry(EntityEntry entry) : super(
		id: entry.key,
		codeName: entry.value[Field.codeName] as String
	);

	InstructorModel.fromEntity(Instructor entity) : super(
		id: entity.id,
		codeName: entity.codeName
	);

	@override
	ObjectMap get object => {
		Field.codeName: codeName
	};
}
