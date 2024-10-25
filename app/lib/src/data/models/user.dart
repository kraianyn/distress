import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/user.dart';

import '../types.dart';


/// `{
/// 	codeName?: String,
/// 	roles: List<String>
/// }`
class UserModel extends User {
	const UserModel({
		required super.id,
		super.codeName,
		required super.roles
	});

	factory UserModel.fromDocument(DocumentSnapshot<ObjectMap> snapshot) {
		final data = snapshot.data()!;
		return UserModel(
			id: snapshot.id,
			codeName: data[Field.codeName] as String?,
			roles: rolesFromDocument(data[Field.roles])
		);
	}

	static List<Role> rolesFromDocument(dynamic list) {
		return List<String>.from(list).map(
			(name) => Role.values.firstWhere((a) => a.name == name)
		).toList();
	}
}
