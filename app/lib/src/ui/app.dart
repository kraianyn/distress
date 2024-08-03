import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'sections/section.dart';


class App extends HookWidget {
	const App();

	@override
	Widget build(BuildContext context) {
		final sectionIndex = useState(0);

		return MaterialApp(
			title: "Дистрес",
			home: Scaffold(
				body: Section.values[sectionIndex.value].widget,
				bottomNavigationBar: NavigationBar(
					destinations: Section.values.map((section) => NavigationDestination(
						icon: Icon(section.icon),
						label: section.name
					)).toList(),
					selectedIndex: sectionIndex.value,
					onDestinationSelected: (index) => sectionIndex.value = index,
				)
			)
		);
	}
}
