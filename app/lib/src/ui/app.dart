import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/providers/app_state_provider.dart';

import 'states/authentication.dart';
import 'states/authorization.dart';
import 'states/home/home.dart';
import 'states/user_form.dart';


class App extends ConsumerWidget {
	const App();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final theme = ThemeData(
			colorScheme: ColorScheme.fromSeed(
				seedColor: const HSLColor.fromAHSL(1, 65, .5, .5).toColor(),
				surfaceContainer: const HSLColor.fromAHSL(1, 65, .3, .6).toColor()
			),
			scaffoldBackgroundColor: const HSLColor.fromAHSL(1, 65, .5, .8).toColor(),
			textTheme: GoogleFonts.ubuntuTextTheme(const TextTheme(
				titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
				headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)
			))
		);

		return MaterialApp(
			title: "Дистрес",
			home: ref.watch(appStateNotifierProvider).widget,
			theme: theme.copyWith(
				appBarTheme: AppBarTheme(
					backgroundColor: theme.colorScheme.surfaceContainer,
					titleTextStyle: theme.textTheme.headlineMedium
				),
				listTileTheme: ListTileThemeData(
					selectedTileColor: theme.colorScheme.surfaceContainer,
					selectedColor: theme.colorScheme.onSurface,
					titleTextStyle: theme.textTheme.titleMedium,
					leadingAndTrailingTextStyle: theme.textTheme.titleMedium
				)
			),
			debugShowCheckedModeBanner: false
		);
	}
}

enum AppState {
	authentication(Authentication()),
	authorization(Authorization()),
	userForm(UserForm()),
	home(Home());

	const AppState(this.widget);

	final Widget widget;
}
