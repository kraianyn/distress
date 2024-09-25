import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/open_page.dart';

import 'package:distress/src/ui/core/providers/app_state.dart';
import 'package:distress/src/ui/core/providers/user.dart';

import 'new_user_page.dart';


class SettingsSection extends ConsumerWidget {
	const SettingsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final userCanAddUsers = ref.watch(userNotifierProvider)!.canAddUsers;

		return Scaffold(
			body: Container(
				alignment: Alignment.center,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						if (userCanAddUsers) FilledButton(
							child: AppIcon.addUser,
							onPressed: () => openPage(context, (_) => const NewUserPage())
						),
						FilledButton(
							child: AppIcon.signOut,
							onPressed: ref.read(appStateNotifierProvider.notifier).signOut
						)
					]
				)
			)
		);
	}
}
