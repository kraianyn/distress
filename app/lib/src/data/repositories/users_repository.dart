import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/user.dart';

import '../models/user.dart';
import '../types.dart';


class UsersRepository {
	UsersRepository({required this.userId});

	final String userId;
	late final DocumentSnapshot<ObjectMap> _userSnapshot;

	Future<bool> userHasAccess() async {
		_userSnapshot = await _userDocument.get();
		return _userSnapshot.exists;
	}

	Future<List<String>?> permissions(String code) async {
		final snapshot = await _accessCodeDocument.get();
		final data = snapshot.data()!;

		return code == data[Field.code] ? List<String>.from(data[Field.permissions]) : null;
	}

	Future<void> initUser(User user) async {
		await _userDocument.set({
			Field.permissions: user.permissions
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

	/// 
	/// `codeName?:String,
	/// permissions: List<String>`
	DocumentReference<ObjectMap> get _userDocument => _collection.doc(userId);

	/// `code: String,
	/// permissions: List<String>`
	DocumentReference<ObjectMap> get _accessCodeDocument => _collection.doc('accessCode');

	CollectionReference<ObjectMap> get _collection => FirebaseFirestore.instance.collection('users');
}
