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

	void init(String id) => state = User(id: id);

	void addActions(List<UserAction> actions) => state = User(
		id: state!.id,
		actions: actions
	);

	void addInfo(String codeName) => state = User(
		id: state!.id,
		codeName: codeName,
		actions: state!.actions
	);

	void set(User user) => state = user;
}
