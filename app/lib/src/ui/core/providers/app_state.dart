import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app.dart';
import '../extensions/providers_references.dart';

part 'app_state.g.dart';


@riverpod
class AppStateNotifier extends _$AppStateNotifier {
	@override
	AppState build() {
		if (ref.user() == null) return AppState.authentication;

		initWithUser();
		return AppState.determiningUserStatus;
	}

	Future<void> initWithUser() async {
		final user = await ref.usersRepository().existingUser();

		if (user != null) {
			ref.userNotifier.set(user);
			state = user.codeName != null ? AppState.home : AppState.userForm;
		}
		else {
			state = AppState.authorization;
		}
	}

	Future<void> signOut() async {
		await ref.userNotifier.signOut();
		state = AppState.authentication;
	}

	void set(AppState appState) => state = appState;
}
