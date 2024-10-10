import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/app_icon.dart';
import '../core/extensions/providers_references.dart';
import '../core/widgets/described_page.dart';


class Authentication extends ConsumerWidget {
	const Authentication();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return DescribedPage(
			title: "Автентифікація",
			text: "Створення акаунту в системі та доступ до нього "
				"здійснюється через акаунт Google.",
			content: [
				FilledButton.icon(
					icon: AppIcon.account,
					label: const Text("Увійти"),
					onPressed: () => _signIn(ref)
				)
			]
		);
	}

	Future<void> _signIn(WidgetRef ref) async {
		final account = await GoogleSignIn().signIn();
		if (account != null) {
			await ref.appStateNotifier.authenticateUser(account);
		}
	}
}
