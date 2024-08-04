import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'sections/section.dart';


class App extends HookWidget {
	const App();

	@override
	Widget build(BuildContext context) {
		final sectionIndex = useState(0);
		final section = Section.values[sectionIndex.value];

		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: "Дистрес",
			home: Scaffold(
				appBar: AppBar(title: Text(section.name)),
				body: section.widget,
				bottomNavigationBar: NavigationBar(
					destinations: Section.values.map((section) => NavigationDestination(
						icon: Icon(section.icon),
						label: section.name
					)).toList(),
					selectedIndex: sectionIndex.value,
					onDestinationSelected: (index) => sectionIndex.value = index
				)
			)
		);
	}
}
