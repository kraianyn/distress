import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/location.dart';
import 'package:distress/src/ui/core/app_icon.dart';

import '../../providers/courses.dart';
import '../../providers/locations.dart';
import '../../providers/pages/location.dart';


class LocationForm extends HookConsumerWidget {
	const LocationForm([this.location]);

	final Location? location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: location?.name);
		final linkField = useTextEditingController(text: location?.link);

		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: nameField,
						decoration: const InputDecoration(hintText: "Назва")
					),
					TextField(
						controller: linkField,
						decoration: const InputDecoration(
							icon: Icon(AppIcon.link),
							hintText: "Посилання"
						)
					)
				]
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(AppIcon.confirm),
				onPressed: location ==  null
					? () => _add(context, ref, nameField.text, linkField.text)
					: () => _update(context, ref, nameField.text, linkField.text)
			)
		);
	}

	void _add(BuildContext context, WidgetRef ref, String name, String link) {
		final location = Location.created(name: name, link: link);
		ref.read(locationsNotifierProvider.notifier).add(location);
		Navigator.of(context).pop();
	}

	void _update(BuildContext context, WidgetRef ref, String name, String link) {
		if (name == location!.name && link == location!.link) return;

		final updatedLocation = location!.copyWith(name: name, link: link);
		ref.read(locationPageNotifierProvider(location!).notifier).update(updatedLocation);
		ref.read(locationsNotifierProvider.notifier).updateLocation(updatedLocation);
		ref.read(coursesNotifierProvider.notifier).updateLocation(updatedLocation);
		Navigator.of(context).pop();
	}
}
