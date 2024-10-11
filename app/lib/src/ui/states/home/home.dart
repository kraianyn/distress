import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/theme.dart';
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
		final textStyle = Theme.of(context).textTheme.headlineLarge!;
		final textHeight = textStyle.fontSize! * textStyle.height!;
		const lineHeight = 2.0;
		final height = textHeight + paddingSize * 2 + lineHeight;

		return PreferredSize(
			preferredSize: Size.fromHeight(height),
			child: SafeArea(child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Padding(
						padding: paddingAround,
						child: Text(section.name, style: textStyle)
					),
					Padding(
						padding: horizontalPadding,
						child: Container(height: lineHeight, color: Colors.black)
					)
				]
			))
		);
	}
}
