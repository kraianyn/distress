import 'package:distress/src/domain/entities/location.dart';

import '../types.dart';


/// `id: {
/// 	name: String,
/// 	city: String
/// 	link: string
/// }`
extension LocationModel on Location {
	static Location fromEntry(EntityEntry entry) => Location(
		id: entry.key,
		name: entry.value[Field.name] as String,
		city: entry.value[Field.city] as String,
		link: entry.value[Field.link] as String
	);

	ObjectMap toObject() => {
		Field.name: name,
		Field.city: city,
		Field.link : link
	};
}
