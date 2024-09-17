import 'package:cloud_firestore/cloud_firestore.dart';

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

	Future<List<UserAction>?> newUserActions(String code) async {
		final snapshot = await _accessCodeDocument.get();
		final data = snapshot.data()!;
		return code == data[Field.code]
			? UserModel.actionsFromDocument(data[Field.actions])
			: null;
	}

	Future<void> initUser() async {
		await _userDocument.set({
			Field.actions: user.actions
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
		await _accessCodeDocument.set({
			Field.code: code,
			Field.actions: actions.map((a) => a.name).toList()
		});
		return code;
	}

	/// `codeName?:String,
	/// actions: List<String>`
	DocumentReference<ObjectMap> get _userDocument => _collection.doc(user.id);

	/// `code: String,
	/// actions: List<String>`
	DocumentReference<ObjectMap> get _accessCodeDocument => _collection.doc('accessCode');

	CollectionReference<ObjectMap> get _collection => FirebaseFirestore.instance.collection('users');
}
