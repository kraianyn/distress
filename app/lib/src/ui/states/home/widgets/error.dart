import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';


class ErrorWidget extends StatelessWidget {
	const ErrorWidget(this.error);

	final Object error;

	@override
	Widget build(BuildContext context) {
		return Container(
			color: const HSLColor.fromAHSL(1, 0, 1, .8).toColor(),
			alignment: Alignment.center,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					AppIcon.error,
					Text(error.toString())
				]
			)
		);
	}
}
