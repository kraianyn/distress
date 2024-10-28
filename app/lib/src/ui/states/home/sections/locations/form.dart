import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/extensions/text_editing_controller.dart';

import '../../widgets/entity_form.dart';


class LocationForm extends HookConsumerWidget {
	const LocationForm([this.location]);

	final Location? location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: location?.name);
		final cityField = useTextEditingController(text: location?.city);
		final linkField = useTextEditingController(text: location?.link);

		final textTheme = Theme.of(context).textTheme;

		return EntityForm(
			adding: location == null,
			action: location ==  null
				? () => _add(context, ref, nameField, cityField, linkField)
				: () => _update(context, ref, nameField, cityField, linkField),
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
					controller: cityField,
					style: textTheme.titleMedium,
					decoration: const InputDecoration(
						icon: AppIcon.city,
						hintText: "Місто"
					)
				),
				TextField(
					controller: linkField,
					style: textTheme.titleMedium,
					decoration: const InputDecoration(
						icon: AppIcon.link,
						hintText: "Посилання"
					)
				)
			].map((w) => w.withHorizontalPadding)
		);
	}

	void _add(
		BuildContext context,
		WidgetRef ref,
		TextEditingController nameField,
		TextEditingController cityField,
		TextEditingController linkField
	) {
		final name = nameField.trimmedText,
			city = cityField.trimmedText,
			link = linkField.trimmedText;
		if (name.isEmpty || city.isEmpty || link.isEmpty) return;

		ref.locationsNotifier.add(Location.added(
			name: name,
			city: city,
			link: link
		));
		context.closePage(location);
	}

	void _update(
		BuildContext context,
		WidgetRef ref,
		TextEditingController nameField,
		TextEditingController cityField,
		TextEditingController linkField
	) {
		final name = nameField.trimmedText,
			city = cityField.trimmedText,
			link = linkField.trimmedText;
		if (
			name != location!.name
			|| city != location!.city
			|| link != location!.link
		) {
			ref.locationsNotifier.updateLocation(location!.copyWith(
				name: name,
				city: city,
				link: link
			));
		}

		context.closePage();
	}
}
