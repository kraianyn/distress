import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/user.dart';

import '../types.dart';


class UserModel extends User {
	const UserModel({
		required super.id,
		super.codeName,
		required super.permissions
	});

	factory UserModel.fromDocument(DocumentSnapshot<ObjectMap> snapshot) {
		final data = snapshot.data()!;
		return UserModel(
			id: snapshot.id,
			codeName: data[Field.codeName] as String?,
			permissions: List<String>.from(data[Field.permissions])
		);
	}
}
