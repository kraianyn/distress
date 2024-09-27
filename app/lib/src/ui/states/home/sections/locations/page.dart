import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/open_page.dart';

import '../../providers/courses.dart';
import '../../providers/locations.dart';
import '../../providers/pages/location.dart';

import '../../widgets/entity_page.dart';
import '../schedule/tile.dart';

import 'form.dart';


class LocationPage extends ConsumerWidget {
	const LocationPage(this.location);

	final Location location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final location = ref.watch(locationPageNotifierProvider(this.location));
		final courses = ref.watch(coursesNotifierProvider).value?.where(
			(course) => course.location == location
		);

		return EntityPage(
			content: [
				EntityTitle(location.name),
				ListTile(
					title: Text(location.city),
					leading: AppIcon.city
				),
				ListTile(
					title: Text(location.link),
					leading: AppIcon.link
				),
				if (courses != null) ...[
					const ListTile(),
					...courses.map(CourseTile.new)
				]
			],
			actions: [
				IconButton(
					icon: AppIcon.change,
					tooltip: "Змінити",
					onPressed: () => openPage(context, (_) => LocationForm(location))
				),
				IconButton(
					icon: AppIcon.delete,
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).deleteWithLocation(location);
		ref.read(locationsNotifierProvider.notifier).delete(location);
		Navigator.pop(context);
	}
}
