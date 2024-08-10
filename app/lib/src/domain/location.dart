import 'entity.dart';


class Location extends Entity {
	const Location({
		required super.id,
		required this.name,
		required this.link
	});

	Location.created({
		required this.name,
		required this.link
	}) : super.created(core: [name]);

	final String name;
	final String link;

	@override
	int compareTo(covariant Location other) => name.compareTo(other.name);

	@override
	String toString() => name;
}
