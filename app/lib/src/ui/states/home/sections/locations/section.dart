import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/locations.dart';
import 'tile.dart';
import '../entities_section.dart';
import 'form.dart';


class LocationsSection extends ConsumerWidget {
	const LocationsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final locations = ref.watch(locationsNotifierProvider);

		return EntitiesSection(
			entities: locations,
			tileBuilder: LocationTile.new,
			formBuilder: (_) => const LocationForm()
		);
	}
}
