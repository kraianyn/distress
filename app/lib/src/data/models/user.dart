import 'package:distress/src/domain/user.dart';

import '../types.dart';


class UserModel extends User {
	const UserModel({
		required super.id,
		required super.codeName,
		required super.permissions
	});

	UserModel.fromObject(String id, ObjectMap object) : this(
		id: id,
		codeName: object[Field.codeName] as String,
		permissions: List<String>.from(object[Field.permissions])
	);
}
