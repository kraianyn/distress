import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/theme.dart';
import 'core/providers/app_state.dart';

import 'states/authentication.dart';
import 'states/authorization.dart';
import 'states/home/home.dart';
import 'states/determining_user_status.dart';
import 'states/user_form.dart';


class App extends ConsumerWidget {
	const App();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final widget = ref.watch(appStateNotifierProvider).widget;

		return MaterialApp(
			title: "Дистрес",
			home: widget,
			theme: theme,
			debugShowCheckedModeBanner: false
		);
	}
}

enum AppState {
	authentication(Authentication()),
	determiningUserStatus(DeterminingUserStatus()),
	authorization(Authorization()),
	userForm(UserForm()),
	home(Home());

	const AppState(this.widget);

	final Widget widget;
}
