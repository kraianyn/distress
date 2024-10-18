import 'package:distress/src/domain/entities/location.dart';

import '../types.dart';
import 'entity.dart';


/// `id: {
/// 	name: String,
/// 	city: String
/// 	link: string
/// }`
class LocationModel extends Location implements EntityModel {
	LocationModel.fromEntry(EntityEntry entry) : super(
		id: entry.key,
		name: entry.value[Field.name] as String,
		city: entry.value[Field.city] as String,
		link: entry.value[Field.link] as String
	);

	LocationModel.fromEntity(Location entity) : super(
		id: entity.id,
		name: entity.name,
		city: entity.city,
		link: entity.link
	);

	@override
	ObjectMap toObject() => {
		Field.name: name,
		Field.city: city,
		Field.link : link
	};
}
