import 'entity.dart';


class Location extends Entity {
	const Location({
		required super.id,
		required this.name,
		required this.city,
		required this.link
	});

	Location.added({
		required this.name,
		required this.city,
		required this.link
	}) : super.added(core: [name, city]);

	final String name;
	final String city;
	final String link;

	Location copyWith({String? name, String? city, String? link}) => Location(
		id: id,
		name: name ?? this.name,
		city: city ?? this.city,
		link: link ?? this.link
	);

	@override
	int compareTo(covariant Location other) => name.compareTo(other.name);

	@override
	String toString() => "$name, $city";
}
