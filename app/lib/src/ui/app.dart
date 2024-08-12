import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sections/section.dart';


class App extends HookWidget {
	const App();

	@override
	Widget build(BuildContext context) {
		final sectionIndex = useState(0);
		final section = Section.values[sectionIndex.value];

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
			home: Scaffold(
				appBar: AppBar(title: Text(section.name)),
				body: section.widget,
				bottomNavigationBar: NavigationBar(
					selectedIndex: sectionIndex.value,
					labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
					destinations: Section.values.map((section) => NavigationDestination(
						icon: Icon(section.icon),
						label: section.name
					)).toList(),
					onDestinationSelected: (index) => sectionIndex.value = index
				)
			),
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
