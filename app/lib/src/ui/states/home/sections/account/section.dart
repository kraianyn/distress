import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../widgets/home_app_bar.dart';
import '../../widgets/show_action_confirmation.dart';
import '../section.dart';

import 'new_user_page.dart';


class AccountSection extends ConsumerWidget {
	const AccountSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final userCanAddUsers = ref.user()!.canManageUsers;

		return Scaffold(
			appBar: HomeAppBar(
				context: context,
				section: Section.account
			),
			body: Container(
				alignment: Alignment.center,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						if (userCanAddUsers) FilledButton.icon(
							icon: AppIcon.addUser,
							label: const Text("Додати користувача"),
							onPressed: () => context.openPage((_) => const NewUserPage())
						),
						verticalSpaceLarge,
						FilledButton.icon(
							icon: AppIcon.signOut,
							label: const Text("Вийти"),
							onPressed: () => showActionConfirmation(
								context: context,
								question: "Вийти з акаунта?",
								action: ref.appStateNotifier.signOut
							)
						)
					]
				)
			)
		);
	}
}
