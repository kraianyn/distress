import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app.dart';

import 'user.dart';
import 'users_repository.dart';

part 'app_state.g.dart';


@riverpod
class AppStateNotifier extends _$AppStateNotifier {
	@override
	AppState build() {
		final user = FirebaseAuth.instance.currentUser;
		if (user == null) return AppState.authentication;

		ref.read(userNotifierProvider.notifier).init(user.uid);
		initWithUser();
		return AppState.determiningUserStatus;
	}

	Future<void> initWithUser() async {
		final repository = ref.read(usersRepositoryProvider);
		final user = await repository.existingUser();

		if (user != null) {
			ref.read(userNotifierProvider.notifier).set(user);

			if (user.codeName != null) {
				state = AppState.home;
			}
			else {
				state = AppState.userForm;
			}
		}
		else {
			state = AppState.authorization;
		}
	}

	void set(AppState appState) => state = appState;
}
