import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app.dart';
import '../core/app_icon.dart';

import '../core/providers/app_state.dart';
import '../core/providers/user.dart';
import '../core/providers/users_repository.dart';


class Authentication extends ConsumerWidget {
	const Authentication();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(
			appBar: AppBar(title: const Text("Автентифікація")),
			body: Center(child: FilledButton(
				child: AppIcon.account,
				onPressed: () => _signIn(ref)
			))
		);
	}

	Future<void> _signIn(WidgetRef ref) async {
		final account = await GoogleSignIn().signIn();
		if (account == null) return;

		final credential = await ref.read(usersRepositoryProvider).signIn(account);
		ref.read(userNotifierProvider.notifier).init(credential.user!.uid);

		final appStateNotifier = ref.read(appStateNotifierProvider.notifier);
		if (credential.additionalUserInfo!.isNewUser) {
			appStateNotifier.set(AppState.authorization);
		}
		else {
			await appStateNotifier.initWithUser();
		}
	}
}
