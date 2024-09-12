import 'package:cloud_firestore/cloud_firestore.dart';

import '../types.dart';


class UsersRepository {
	Future<String> createAccessCode(List<String> permissions) async {
		String code = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
		code = (code.split('')..shuffle()).join().toUpperCase();
		await _document.update({
			Field.code: code,
			Field.permissions: permissions
		});
		return code;
	}

	/// `code: String,
	/// permissions: List<String>`
	DocumentReference<ObjectMap> get _document =>
		FirebaseFirestore.instance.collection('users').doc('accessCode');
}
