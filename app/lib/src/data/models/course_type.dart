import 'package:distress/src/domain/course_type.dart';
import '../field.dart';


class CourseTypeModel extends CourseType {
	const CourseTypeModel({
		required super.id,
		required super.name
	});

	CourseTypeModel.fromCloudFormat({
		required String id,
		required Map<String, dynamic> object
	}) : this(
		id: id,
		name: object[Field.name] as String
	);
}
