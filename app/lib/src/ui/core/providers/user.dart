import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/user.dart';

part 'user.g.dart';


@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
	@override
	User? build() => null;

	void init(String id) => state = User(id: id);

	void set(User user) => state = user;

	void addPermissions(List<String> permissions) => state = User(
		id: state!.id,
		permissions: permissions
	);

	void addInfo(String codeName) => state = User(
		id: state!.id,
		codeName: codeName,
		permissions: state!.permissions
	);
}
