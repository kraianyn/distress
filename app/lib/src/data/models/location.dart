import 'package:distress/src/domain/location.dart';

import '../field.dart';
import '../schedule_repository.dart';

import 'entity.dart';


class LocationModel extends Location implements EntityModel {
	const LocationModel({
		required super.id,
		required super.name,
		required super.link
	});

	LocationModel.fromEntry(DocumentEntry entry) : this(
		id: entry.key,
		name: entry.value[Field.name] as String,
		link: entry.value[Field.link] as String
	);

	LocationModel.fromEntity(Location entity) : this(
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
