import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app.dart';

import '../core/providers/app_state.dart';
import '../core/providers/user.dart';


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

		ref.read(userNotifierProvider.notifier).init(userCredential.user!.uid);
		await _setAppState(ref, userCredential);
	}

	Future<void> _setAppState(WidgetRef ref, UserCredential userCredential) async {
		final appStateNotifier = ref.read(appStateNotifierProvider.notifier);

		if (userCredential.additionalUserInfo!.isNewUser) {
			appStateNotifier.set(AppState.authorization);
		}
		else {
			await appStateNotifier.initWithUser();
		}
	}
}
