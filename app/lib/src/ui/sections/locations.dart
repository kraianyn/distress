import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/locations.dart';
import '../widgets/entity_tile.dart';

import 'entities_section.dart';
import 'forms/location.dart';
import 'pages/location.dart';


class LocationsSection extends ConsumerWidget {
	const LocationsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final locations = ref.watch(locationsNotifierProvider);

		return EntitiesSection(
			entities: locations,
			tileBuilder: (location) => EntityTile(
				title: location.name,
				subtitle: location.link,
				pageBuilder: (context) => LocationPage(location)
			),
			formBuilder: (context) => const LocationForm(),
		);
	}
}
