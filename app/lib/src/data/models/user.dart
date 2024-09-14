import 'package:distress/src/domain/user.dart';

import '../types.dart';


class UserModel extends User {
	UserModel.fromObject(String id, ObjectMap object) : super(
		id: id,
		codeName: object[Field.codeName] as String,
		permissions: List<String>.from(object[Field.permissions])
	);
}
