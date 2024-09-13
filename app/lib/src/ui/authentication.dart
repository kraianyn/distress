import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Authentication extends StatelessWidget {
	const Authentication();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text("Автентифікація")),
			body: Center(child: FilledButton(
				child: const Icon(Icons.account_circle),
				onPressed: () => _signIn()
			))
		);
	}

	Future<void> _signIn() async {
		final account = await GoogleSignIn().signIn();
		if (account == null) return;

		final authentication = await account.authentication;
		final credential = GoogleAuthProvider.credential(
			idToken: authentication.idToken,
			accessToken: authentication.accessToken
		);
		final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
	}
}
