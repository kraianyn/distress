import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/navigation_context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import 'new_user_page.dart';


class SettingsSection extends ConsumerWidget {
	const SettingsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final userCanAddUsers = ref.user()!.canAddUsers;

		return Scaffold(
			body: Container(
				alignment: Alignment.center,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						if (userCanAddUsers) FilledButton(
							child: AppIcon.addUser,
							onPressed: () => context.openPage((_) => const NewUserPage())
						),
						FilledButton(
							child: AppIcon.signOut,
							onPressed: ref.appStateNotifier.signOut
						)
					]
				)
			)
		);
	}
}
