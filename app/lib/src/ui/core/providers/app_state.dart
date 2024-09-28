import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app.dart';
import '../extensions/providers_references.dart';

part 'app_state.g.dart';


@riverpod
class AppStateNotifier extends _$AppStateNotifier {
	@override
	AppState build() {
		final user = ref.user(watch: false);
		if (user == null) return AppState.authentication;

		initializeWithUser();
		return AppState.determiningUserStatus;
	}

	Future<void> authenticateUser(GoogleSignInAccount account) async {
		final credential = await ref.usersRepository().signIn(account);
		ref.userNotifier.initialize(credential.user!.uid);

		if (credential.additionalUserInfo!.isNewUser) {
			state = AppState.authorization;
		}
		else {
			await initializeWithUser();
		}
	}

	Future<void> initializeWithUser() async {
		final user = await ref.usersRepository().existingUser();

		if (user != null) {
			ref.userNotifier.set(user);
			state = user.codeName != null ? AppState.home : AppState.introduction;
		}
		else {
			state = AppState.authorization;
		}
	}

	Future<void> authorizeUser(List<UserAction> actions) async {
		ref.userNotifier.addActions(actions);
		await ref.usersRepository().initializeUser();
		state = AppState.introduction;
	}

	Future<void> saveUserInfo(String codeName) async {
		ref.userNotifier.addInfo(codeName);
		final user = ref.user(watch: false)!;
		await Future.wait([
			ref.usersRepository().saveUserInfo(),
			if (user.isInstructor) ref.instructorsNotifier.add(
				Instructor(id: user.id, codeName: codeName)
			)
		]);
		state = AppState.home;
	}

	Future<void> signOut() async {
		await ref.usersRepository().signOut();
		ref.userNotifier.signOut();
		state = AppState.authentication;
	}
}
