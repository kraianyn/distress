import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';


class EntityForm extends StatelessWidget {
	const EntityForm({
		this.adding = true,
		required this.action,
		required this.content
	});

	final bool adding;
	final void Function() action;
	final Iterable<Widget> content;

	@override
	Widget build(BuildContext context) {
		return Scaffold(body: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				...content,
				verticalSpaceLarge,
				FilledButton.icon(
					label: Text(adding ? "Додати" : "Змінити"),
					icon: AppIcon.confirm,
					onPressed: action
				).withHorizontalPadding
			]
		));
	}
}
