import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/user.dart';

import '../types.dart';


class UsersRepository {
	late final DocumentSnapshot<ObjectMap> _userSnapshot;

	Future<bool> userHasAccess(String id) async {
		_userSnapshot = await _collection.doc(id).get();
		return _userSnapshot.exists;
	}

	User? user() {
		if (!_userSnapshot.exists) return null;

		final data = _userSnapshot.data()!;
		return User(
			id: _userSnapshot.id,
			codeName: data[Field.codeName]
		);
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

	/// `code: String,
	/// permissions: List<String>`
	DocumentReference<ObjectMap> get _accessCodeDocument => _collection.doc('accessCode');
}
