import 'package:distress/src/domain/entities/instructor.dart';

import '../types.dart';


/// `id: {
/// 	codeName: String
/// }`
extension InstructorModel on Instructor {
	static Instructor fromEntry(EntityEntry entry) => Instructor(
		id: entry.key,
		codeName: entry.value[Field.codeName] as String
	);

	ObjectMap toObject() => {
		Field.codeName: codeName
	};
}
