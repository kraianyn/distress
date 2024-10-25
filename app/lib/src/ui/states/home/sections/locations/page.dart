import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../providers/courses.dart';

import '../../widgets/course_component_page.dart';
import '../../widgets/delete_action_button.dart';
import '../../widgets/modify_action_button.dart';

import 'form.dart';


class LocationPage extends ConsumerWidget {
	const LocationPage(this.location);

	final Location location;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final location = ref.locations().value!.firstWhere((l) => l == this.location);
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
					leading: AppIcon.link,
					onTap: () => _openLink(context),
					onLongPress: () => Clipboard.setData(
						ClipboardData(text: location.link)
					)
				)
			],
			courses: courses,
			actions: [
				ModifyActionButton(formBuilder: (_) => LocationForm(location)),
				DeleteActionButton(
					question: "Видалити локацію?",
					text: "Заплановані на ній курси теж буде видалено.",
					delete: () => ref.locationsNotifier.delete(location)
				)
			]
		);
	}

	Future<void> _openLink(BuildContext context) async {
		try {
			await launchUrl(Uri.parse(location.link));
		}
		on PlatformException {
			context.showSnackBar("Не вдалося відкрити посилання");
		}
	}
}
