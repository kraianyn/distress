import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';

import '../../providers/courses.dart';
import '../../providers/locations.dart';
import '../../providers/pages/location.dart';

import '../../widgets/entity_form.dart';


class LocationForm extends HookConsumerWidget {
	const LocationForm([this.location]);

	final Location? location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: location?.name);
		final linkField = useTextEditingController(text: location?.link);

		final textTheme = Theme.of(context).textTheme;

		return EntityForm(
			content: [
				TextField(
					controller: nameField,
					style: textTheme.headlineMedium,
					decoration: InputDecoration(
						hintText: "Назва",
						hintStyle: headlineHintTextStyle
					)
				),
				TextField(
					controller: linkField,
					style: textTheme.titleMedium,
					decoration: const InputDecoration(
						icon: Icon(AppIcon.link),
						hintText: "Посилання"
					)
				)
			],
			onConfirm: location ==  null
				? () => _add(context, ref, nameField, linkField)
				: () => _update(context, ref, nameField, linkField)
		);
	}

	void _add(
		BuildContext context,
		WidgetRef ref,
		TextEditingController nameField,
		TextEditingController linkField
	) {
		final name = nameField.text.trim(), link = linkField.text.trim();
		if (name.isEmpty || link.isEmpty) return;

		final location = Location.added(name: name, link: link);
		ref.read(locationsNotifierProvider.notifier).add(location);
		Navigator.pop(context, location);
	}

	void _update(
		BuildContext context,
		WidgetRef ref,
		TextEditingController nameField,
		TextEditingController linkField
	) {
		final name = nameField.text.trim(), link = linkField.text.trim();
		if (name == location!.name && link == location!.link) return;

		final updatedLocation = location!.copyWith(name: name, link: link);
		ref.read(locationPageNotifierProvider(location!).notifier).update(updatedLocation);
		ref.read(locationsNotifierProvider.notifier).updateLocation(updatedLocation);
		ref.read(coursesNotifierProvider.notifier).updateLocation(updatedLocation);
		Navigator.pop(context);
	}
}
