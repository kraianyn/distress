import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/navigation_context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/states/home/providers/courses.dart';

import '../../providers/pages/location.dart';
import '../../widgets/course_component_page.dart';

import 'form.dart';


class LocationPage extends ConsumerWidget {
	const LocationPage(this.location);

	final Location location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final location = ref.watch(locationPageNotifierProvider(this.location));
		final courses = ref.courses().withLocation(location)?.toList();

		return CourseComponentPage(
			title: location.name,
			content: [
				ListTile(
					title: Text(location.city),
					leading: AppIcon.city
				),
				ListTile(
					title: Text(location.link),
					leading: AppIcon.link
				)
			],
			courses: courses,
			actions: [
				IconButton(
					icon: AppIcon.modify,
					tooltip: "Змінити",
					onPressed: () => context.openPage((_) => LocationForm(location))
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
		ref.locationsNotifier.delete(location);
		Navigator.pop(context);
	}
}
