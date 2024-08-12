import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/location.dart';

import '../../app_icon.dart';
import '../../open_page.dart';

import '../../providers/courses.dart';
import '../../providers/locations.dart';
import '../../providers/pages/location.dart';

import '../../widgets/entity_title.dart';
import '../../widgets/tiles/course.dart';

import '../forms/location.dart';
import 'entity.dart';


class LocationPage extends ConsumerWidget {
	const LocationPage(this.location);

	final Location location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final location = ref.watch(locationPageNotifierProvider(this.location));
		final courses = ref.watch(coursesNotifierProvider).value!;
		final relevantCourses = courses.where((c) => c.location == location);

		return EntityPage(
			content: [
				EntityTitle(location.name),
				ListTile(
					title: Text(location.link),
					leading: const Icon(AppIcon.link)
				),
				const ListTile(),
				...relevantCourses.map(CourseTile.new)
			],
			actions: [
				IconButton(
					icon: const Icon(AppIcon.change),
					tooltip: "Змінити",
					onPressed: () => openPage(context, (_) => LocationForm(location))
				),
				IconButton(
					icon: const Icon(AppIcon.delete),
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
