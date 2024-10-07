import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:distress/src/ui/core/theme.dart';

import 'sections/section.dart';


class Home extends HookWidget {
	const Home();

	@override
	Widget build(BuildContext context) {
		final section = useState(Section.schedule);

		return Scaffold(
			appBar: appBar(context, section.value),
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

	PreferredSize appBar(BuildContext context, Section section) {
		final textStyle = Theme.of(context).textTheme.headlineLarge;
		const lineHeight = 2.0;
		final height = textStyle!.fontSize! + paddingSize * 2 + lineHeight;

		return PreferredSize(
			preferredSize: Size.fromHeight(height),
			child: SafeArea(child: Padding(
				padding: padding.copyWith(bottom: 0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(section.name, style: textStyle),
						verticalSpaceMedium,
						Container(height: lineHeight, color: Colors.black)
					]
				)
			))
		);
	}
}
