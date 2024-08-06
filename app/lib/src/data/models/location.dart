import 'package:distress/src/domain/location.dart';

import '../field.dart';
import '../types.dart';


class LocationModel extends Location {
	const LocationModel({
		required super.id,
		required super.name,
		required super.link
	});

	LocationModel.fromEntry(MapEntry<String, ObjectMap> entry) : this(
		id: entry.key,
		name: entry.value[Field.name] as String,
		link: entry.value[Field.link] as String
	);

	LocationModel.fromEntity(Location location) : this(
		id: location.id,
		name: location.name,
		link: location.link
	);

	MapEntry<String, ObjectMap> get entry => MapEntry(id, {
		Field.name: name,
		Field.link : link
	});
}
