import 'entity.dart';


class CourseType extends Entity {
	const CourseType({
		required super.id,
		required this.name
	});

	final String name;
	
	@override
	String toString() => name;
}
