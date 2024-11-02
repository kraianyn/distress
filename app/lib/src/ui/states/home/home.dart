import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'sections/section.dart';


class Home extends HookWidget {
	const Home();

	@override
	Widget build(BuildContext context) {
		final section = useState(Section.schedule);

		return Scaffold(
			body: section.value.widget,
			bottomNavigationBar: NavigationBar(
				selectedIndex: section.value.index,
				destinations: Section.values.map((section) => NavigationDestination(
					icon: section.icon,
					label: section.name
				)).toList(),
				onDestinationSelected: (index) => section.value = Section.values[index]
			)
		);
	}
}
