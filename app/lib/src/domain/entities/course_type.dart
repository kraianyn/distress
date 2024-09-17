import 'entity.dart';


class CourseType extends Entity {
	const CourseType({
		required super.id,
		required this.name,
		required this.courseCount
	});

	CourseType.created({
		required this.name,
		required this.courseCount
	}) : super.created(core: [name]);

	final String name;
	final int courseCount;

	CourseType copyWith({String? name}) => CourseType(
		id: id,
		name: name ?? this.name,
		courseCount: courseCount
	);

	@override
	int compareTo(covariant CourseType other) => name.compareTo(other.name);

	@override
	String toString() => name;
}
