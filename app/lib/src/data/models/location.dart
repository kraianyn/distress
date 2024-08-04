import 'package:distress/src/domain/location.dart';
import '../field.dart';


class LocationModel extends Location {
	const LocationModel({
		required super.id,
		required super.name,
		required super.link
	});

	LocationModel.fromCloudFormat({
		required String id,
		required Map<String, dynamic> object
	}) : this(
		id: id,
		name: object[Field.name] as String,
		link: object[Field.link] as String
	);
}
