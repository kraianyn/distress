import 'package:distress/src/domain/entities/location.dart';

import '../types.dart';
import 'entity.dart';


/// `id: {
/// 	name: String,
/// 	link: string
/// }`
class LocationModel extends Location implements EntityModel {
	LocationModel.fromEntry(EntityEntry entry) : super(
		id: entry.key,
		name: entry.value[Field.name] as String,
		link: entry.value[Field.link] as String
	);

	LocationModel.fromEntity(Location entity) : super(
		id: entity.id,
		name: entity.name,
		link: entity.link
	);

	@override
	ObjectMap get object => {
		Field.name: name,
		Field.link : link
	};
}
