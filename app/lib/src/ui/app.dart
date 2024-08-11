import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'sections/section.dart';


class App extends HookWidget {
	const App();

	@override
	Widget build(BuildContext context) {
		final sectionIndex = useState(0);
		final section = Section.values[sectionIndex.value];

		final theme = ThemeData(
			colorSchemeSeed: const HSLColor.fromAHSL(1, 70, .5, .5).toColor()
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
					backgroundColor: theme.colorScheme.surfaceContainer
				),
				listTileTheme: ListTileThemeData(
					selectedTileColor: theme.colorScheme.inversePrimary,
					selectedColor: theme.colorScheme.onSurface
				)
			),
			debugShowCheckedModeBanner: false
		);
	}
}
