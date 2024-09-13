import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app.dart';
import '../core/providers/app_state_provider.dart';
import '../core/providers/users_repository.dart';


class Authentication extends ConsumerWidget {
	const Authentication();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(
			appBar: AppBar(title: const Text("Автентифікація")),
			body: Center(child: FilledButton(
				child: const Icon(Icons.account_circle),
				onPressed: () => _signIn(ref)
			))
		);
	}

	Future<void> _signIn(WidgetRef ref) async {
		final account = await GoogleSignIn().signIn();
		if (account == null) return;

		final authentication = await account.authentication;
		final credential = GoogleAuthProvider.credential(
			idToken: authentication.idToken,
			accessToken: authentication.accessToken
		);
		final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
		await _setAppState(ref, userCredential);
	}

	Future<void> _setAppState(WidgetRef ref, UserCredential userCredential) async {
		final repository = ref.read(usersRepositoryProvider);

		AppState state;
		if (userCredential.additionalUserInfo!.isNewUser) {
			state = AppState.authorization;
		}
		else {
			final userHasAccess = await repository.userHasAccess(userCredential.user!.uid);
			if (userHasAccess) {
				final user = repository.user();
				if (user != null) {
					state = AppState.home;
				}
				else {
					state = AppState.userForm;
				}
			}
			else {
				state = AppState.authorization;
			}
		}
		ref.read(appStateNotifierProvider.notifier).set(state);
	}
}
