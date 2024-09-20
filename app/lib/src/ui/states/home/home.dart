import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'sections/section.dart';


class Home extends HookWidget {
	const Home();

	@override
	Widget build(BuildContext context) {
		final section = useState(Section.schedule);

		return Scaffold(
			appBar: AppBar(title: Text(section.value.name)),
			body: section.value.widget,
			bottomNavigationBar: NavigationBar(
				selectedIndex: section.value.index,
				destinations: Section.values.map((section) => NavigationDestination(
					icon: Icon(section.icon),
					label: section.name
				)).toList(),
				onDestinationSelected: (index) => section.value = Section.values[index]
			)
		);
	}
}
