import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';


void showActionConfirmation({
	required BuildContext context,
	required String question,
	String? text,
	required void Function() action
}) {
	final textTheme = Theme.of(context).textTheme;

	showModalBottomSheet(
		context: context,
		builder: (context) => Column(
			mainAxisSize: MainAxisSize.min,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(question, style: textTheme.headlineSmall),
				if (text != null) ...[
					verticalSpaceSmall,
					Text(text, style: textTheme.bodySmall)
				],
				verticalSpaceMedium,
				FilledButtonTheme(
					data: FilledButtonThemeData(style: smallButtonStyle),
					child: 
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children: [
							FilledButton(
								child: const Text("Так"),
								onPressed: () {
									action();
									context.closePage();
								}
							),
							FilledButton(
								child: const Text("Ні"),
								onPressed: context.closePage
							)
						]
					)
				)
			]
		).withPaddingAround
	);
}
