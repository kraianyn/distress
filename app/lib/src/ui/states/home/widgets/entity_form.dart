import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';


class EntityForm extends StatelessWidget {
	const EntityForm({
		required this.content,
		required this.onConfirm
	});

	final List<Widget> content;
	final void Function() onConfirm;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Padding(
				padding: padding,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: content
				)
			),
			floatingActionButton: FloatingActionButton(
				child: AppIcon.confirm,
				onPressed: onConfirm
			)
		);
	}
}
