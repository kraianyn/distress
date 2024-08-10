import 'entity.dart';


class Instructor extends Entity {
	const Instructor({
		required super.id,
		required this.codeName
	});

	final String codeName;

	@override
	int compareTo(covariant Instructor other) => codeName.compareTo(other.codeName);

	@override
	String toString() => codeName;
}
