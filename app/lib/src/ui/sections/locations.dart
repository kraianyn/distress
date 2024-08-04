import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/locations.dart';
import '../widgets/entity_tile.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';

import 'pages/location.dart';


class LocationsSection extends ConsumerWidget {
	const LocationsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final locations = ref.watch(locationsNotifierProvider);

		return locations.when(
			data: (locations) => ListView(
				children: locations.map((location) => EntityTile(
					title: location.name,
					subtitle: location.link,
					pageBuilder: (context) => LocationPage(location)
				)).toList(),
			),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}
}
