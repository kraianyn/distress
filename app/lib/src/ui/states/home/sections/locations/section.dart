import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/states/home/providers/courses.dart';

import '../entities_section.dart';

import 'tile.dart';
import 'form.dart';


class LocationsSection extends ConsumerWidget {
	const LocationsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final locations = ref.locations();
		final courses = ref.courses();
		final userCanAdd = ref.user()!.canManageSchedule;

		return EntitiesSection(
			entities: locations,
			tileBuilder: (location) => LocationTile(
				location,
				courseCount: courses.atLocation(location)?.length,
			),
			formBuilder: userCanAdd ? LocationForm.new : null
		);
	}
}
