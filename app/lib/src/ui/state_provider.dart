import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app.dart';

part 'state_provider.g.dart';


@riverpod
class AppStateNotifier extends _$AppStateNotifier {
	@override
	AppState build() => AppState.authentication;

	void set(AppState appState) => state = appState;
}
