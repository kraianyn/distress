import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/context.dart';


class ModifyActionButton extends StatelessWidget {
	const ModifyActionButton({required this.formBuilder});

	final Widget Function(BuildContext) formBuilder;

	@override
	Widget build(BuildContext context) {
		return IconButton(
			icon: AppIcon.modify,
			tooltip: "Змінити",
			onPressed: () => context.openPage(formBuilder)
		);
	}
}
