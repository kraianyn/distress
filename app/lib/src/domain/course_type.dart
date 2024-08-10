import 'entity.dart';


class CourseType extends Entity {
	const CourseType({
		required super.id,
		required this.name
	});

	CourseType.created({required this.name}) : super.created(core: [name]);

	final String name;

	@override
	int compareTo(covariant CourseType other) => name.compareTo(other.name);
	
	@override
	String toString() => name;
}
