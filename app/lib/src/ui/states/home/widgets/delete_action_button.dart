import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';

import 'show_action_confirmation.dart';


class DeleteActionButton extends StatelessWidget {
	const DeleteActionButton({
		required this.question,
		this.text,
		required this.delete
	});

	final String question;
	final String? text;
	final void Function() delete;

	@override
	Widget build(BuildContext context) {
		return IconButton(
			icon: AppIcon.delete,
			tooltip: "Видалити",
			onPressed: () => showActionConfirmation(
				context: context,
				question: question,
				text: text,
				action: () {
					delete();
					context.closePage();
				}
			)
		);
	}
}
