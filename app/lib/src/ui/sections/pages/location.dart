import 'package:distress/src/ui/providers/courses.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/location.dart';

import '../../providers/locations.dart';
import 'entity.dart';


class LocationPage extends ConsumerWidget {
	const LocationPage(this.location);

	final Location location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return EntityPage(
			content: [
				Text(location.name),
				Text(location.link)
			],
			actions: [
				IconButton(
					icon: const Icon(Icons.edit),
					tooltip: "Змінити",
					onPressed: () {}
				),
				IconButton(
					icon: const Icon(Icons.delete),
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).deleteWithLocation(location);
		ref.read(locationsNotifierProvider.notifier).delete(location);
		Navigator.of(context).pop();
	}
}
