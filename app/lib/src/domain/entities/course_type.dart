import 'entity.dart';


class CourseType extends Entity {
	const CourseType({
		required super.id,
		required this.name,
		required this.courseCount,
		required this.studentCount,
		required this.certificatesAreIssuedByTrainingCenter
	});

	CourseType.added({
		required this.name,
		required this.courseCount,
		required this.studentCount,
		required this.certificatesAreIssuedByTrainingCenter
	}) : super.added(core: [name]);

	final String name;
	final int courseCount;
	final int studentCount;
	final bool certificatesAreIssuedByTrainingCenter;

	CourseType copyWith({String? name}) => CourseType(
		id: id,
		name: name ?? this.name,
		courseCount: courseCount,
		studentCount: studentCount,
		certificatesAreIssuedByTrainingCenter: certificatesAreIssuedByTrainingCenter
	);

	@override
	int compareTo(covariant CourseType other) => name.compareTo(other.name);

	@override
	String toString() => name;
}
