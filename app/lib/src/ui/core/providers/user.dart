import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/user.dart';

part 'user.g.dart';


@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
	@override
	User? build() {
		final user = FirebaseAuth.instance.currentUser;
		return user != null ? User(id: user.uid) : null;
	}

	void initialize(String id) => state = User(id: id);

	void addActions(List<Role> roles) => state = User(
		id: state!.id,
		roles: roles
	);

	void addInfo(String codeName) => state = User(
		id: state!.id,
		codeName: codeName,
		roles: state!.roles
	);

	void set(User user) => state = user;

	void signOut() => state = null;
}
