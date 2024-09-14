import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/location.dart';

import '../../widgets/entity_tile.dart';
import 'page.dart';


class LocationTile extends StatelessWidget {
	const LocationTile(this.location);

	final Location location;

	@override
	Widget build(BuildContext context) {
		return EntityTile(
			title: location.name,
			pageBuilder: (_) => LocationPage(location)
		);
	}
}
