import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:distress/src/domain/user.dart';

import '../models/user.dart';
import '../types.dart';


class UsersRepository {
	const UsersRepository({required this.user});

	final User user;

	Future<User?> existingUser() async {
		final snapshot = await _userDocument.get();
		return snapshot.exists ? UserModel.fromDocument(snapshot) : null;
	}

	Future<UserCredential> signIn(GoogleSignInAccount account) async {
		final authentication = await account.authentication;
		final credential = GoogleAuthProvider.credential(
			idToken: authentication.idToken,
			accessToken: authentication.accessToken
		);
		return await FirebaseAuth.instance.signInWithCredential(credential);
	}

	Future<List<UserAction>?> newUserActions(String code) async {
		final document = _accessCodeDocument(code);
		final snapshot = await document.get();
		if (!snapshot.exists) return null;

		document.delete();
		return UserModel.actionsFromDocument(snapshot.data()![Field.actions]);
	}

	Future<void> initUser() async {
		await _userDocument.set({
			Field.actions: user.actions!.map((a) => a.name)
		});
	}

	Future<void> addUserInfo() async {
		await _userDocument.update({
			Field.codeName: user.codeName
		});
	}

	Future<String> createAccessCode(List<UserAction> actions) async {
		String code = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
		code = (code.split('')..shuffle()).join().toUpperCase();
		await _accessCodeDocument(code).set({
			Field.actions: actions.map((a) => a.name).toList()
		});
		return code;
	}

	DocumentReference<ObjectMap> get _userDocument =>
		FirebaseFirestore.instance.collection('users').doc(user.id);

	DocumentReference<ObjectMap> _accessCodeDocument(String code) =>
		FirebaseFirestore.instance.collection('accessCodes').doc(code);
}
