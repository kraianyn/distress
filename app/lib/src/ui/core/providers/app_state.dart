import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app.dart';

part 'app_state.g.dart';


@riverpod
class AppStateNotifier extends _$AppStateNotifier {
	@override
	AppState build() => AppState.authentication;

	void set(AppState appState) => state = appState;
}
