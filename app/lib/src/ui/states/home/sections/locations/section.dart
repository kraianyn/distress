import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/providers/user.dart';

import '../../providers/locations.dart';
import '../entities_section.dart';

import 'tile.dart';
import 'form.dart';


class LocationsSection extends ConsumerWidget {
	const LocationsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final locations = ref.watch(locationsNotifierProvider);
		final userCanAdd = ref.watch(userNotifierProvider)!.canManageSchedule;

		return EntitiesSection(
			entities: locations,
			tileBuilder: LocationTile.new,
			formBuilder: userCanAdd ? (_) => const LocationForm() : null
		);
	}
}
