import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:distress/src/domain/user.dart';

import '../types.dart';


/// `{
/// 	codeName?: String,
/// 	actions: List<String>
/// }`
class UserModel extends User {
	const UserModel({
		required super.id,
		super.codeName,
		required super.actions
	});

	factory UserModel.fromDocument(DocumentSnapshot<ObjectMap> snapshot) {
		final data = snapshot.data()!;
		return UserModel(
			id: snapshot.id,
			codeName: data[Field.codeName] as String?,
			actions: actionsFromDocument(data[Field.actions])
		);
	}

	static List<UserAction> actionsFromDocument(dynamic list) {
		return List<String>.from(list).map(
			(name) => UserAction.values.firstWhere((a) => a.name == name)
		).toList();
	}
}
