import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/location.dart';

import '../providers/locations.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';


class LocationsSection extends ConsumerWidget {
	const LocationsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final locations = ref.watch(locationsNotifierProvider);

		return locations.when(
			data: (courses) => _listWidget(courses),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}

	Widget _listWidget(List<Location> locations) => ListView(
		children: locations.map((location) => ListTile(
			title: Text(location.name),
			subtitle: Text(location.link),
		)).toList(),
	);
}
