import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/user.dart';

import '../models/user.dart';
import '../types.dart';


class UsersRepository {
	late final DocumentSnapshot<ObjectMap> _userSnapshot;

	Future<bool> userHasAccess(String id) async {
		_userSnapshot = await _collection.doc(id).get();
		return _userSnapshot.exists;
	}

	Future<List<String>?> permissions(String code) async {
		final snapshot = await _accessCodeDocument.get();
		final data = snapshot.data()!;

		return code == data[Field.code] ? List<String>.from(data[Field.permissions]) : null;
	}

	Future<void> initUser(List<String> permissions) async {
		await _userDocument.set({
			Field.permissions: permissions
		});
	}

	Future<void> setUserInfo(String codeName) async {
		await _userDocument.update({
			Field.codeName: codeName
		});
	}

	User? user() {
		if (!_userSnapshot.exists) return null;

		final data = _userSnapshot.data()!;
		final hasInfo = data.containsKey(Field.codeName);
		return hasInfo ? UserModel.fromObject(_userSnapshot.id, data) : null;
	}

	Future<String> createAccessCode(List<String> permissions) async {
		String code = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
		code = (code.split('')..shuffle()).join().toUpperCase();
		await _accessCodeDocument.update({
			Field.code: code,
			Field.permissions: permissions
		});
		return code;
	}

	CollectionReference<ObjectMap> get _collection => FirebaseFirestore.instance.collection('users');

	DocumentReference<ObjectMap> get _userDocument => _collection.doc(_userSnapshot.id);

	/// `code: String,
	/// permissions: List<String>`
	DocumentReference<ObjectMap> get _accessCodeDocument => _collection.doc('accessCode');
}
