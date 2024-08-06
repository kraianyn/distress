import 'entity.dart';


class Instructor extends Entity {
	const Instructor({
		required super.id,
		required this.codeName
	});

	final String codeName;

	@override
	String toString() => codeName;
}
