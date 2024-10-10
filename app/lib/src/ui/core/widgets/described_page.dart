import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme.dart';


class DescribedPage extends ConsumerWidget {
	const DescribedPage({
		required this.title,
		required this.text,
		required this.content
	});

	final String title;
	final String text;
	final List<Widget> content;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(body: Padding(
			padding: padding,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						title,
						style: Theme.of(context).textTheme.headlineLarge
					),
					verticalSpaceMedium,
					Text(text),
					const ListTile(),
					...content
				]
			)
		));
	}
}
