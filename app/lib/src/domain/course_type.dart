import 'entity.dart';


class CourseType extends Entity {
	const CourseType({
		required super.id,
		required this.name
	});

	CourseType.created({required this.name}) : super.created(core: [name]);

	final String name;

	CourseType copyWith({String? name}) => CourseType(
		id: id,
		name: name ?? this.name
	);

	@override
	int compareTo(covariant CourseType other) => name.compareTo(other.name);

	@override
	bool operator ==(covariant CourseType other) => id == other.id;

	@override
	int get hashCode => id.hashCode;
	
	@override
	String toString() => name;
}
