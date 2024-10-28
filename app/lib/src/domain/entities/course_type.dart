import 'entity.dart';


class CourseType extends Entity {
	const CourseType({
		required super.id,
		required this.name,
		required this.courseCount,
		required this.studentCount
	});

	CourseType.added({
		required this.name,
		required this.courseCount,
		required this.studentCount
	}) : super.added(core: [name]);

	final String name;
	final int courseCount;
	final int studentCount;

	CourseType copyWith({String? name}) => CourseType(
		id: id,
		name: name ?? this.name,
		courseCount: courseCount,
		studentCount: studentCount
	);

	@override
	int compareTo(covariant CourseType other) => name.compareTo(other.name);

	@override
	String toString() => name;
}
