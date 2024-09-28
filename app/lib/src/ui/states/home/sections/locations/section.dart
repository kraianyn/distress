import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../entities_section.dart';

import 'tile.dart';
import 'form.dart';


class LocationsSection extends ConsumerWidget {
	const LocationsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final locations = ref.locations();
		final userCanAdd = ref.user()!.canManageSchedule;

		return EntitiesSection(
			entities: locations,
			tileBuilder: LocationTile.new,
			formBuilder: userCanAdd ? LocationForm.new : null
		);
	}
}
