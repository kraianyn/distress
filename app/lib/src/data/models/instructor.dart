import 'package:distress/src/domain/instructor.dart';
import '../field.dart';


class InstructorModel extends Instructor {
	const InstructorModel({
		required super.id,
		required super.codeName
	});

	InstructorModel.fromCloudFormat({
		required String id,
		required Map<String, dynamic> object
	}) : this(
		id: id,
		codeName: object[Field.codeName] as String
	);
}
