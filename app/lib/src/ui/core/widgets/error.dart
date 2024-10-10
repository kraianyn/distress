import 'package:flutter/material.dart';

import '../theme.dart';


class ErrorWidget extends StatelessWidget {
	const ErrorWidget(this.error, [this.stackTrace]);

	final Object error;
	final StackTrace? stackTrace;

	@override
	Widget build(BuildContext context) {
		return Container(
			color: const HSLColor.fromAHSL(1, 0, 1, .8).toColor(),
			padding: padding,
			alignment: Alignment.center,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Text(
						error.toString(),
						style: Theme.of(context).textTheme.titleMedium
					),
					verticalSpaceMedium,
					Text(stackTrace.toString())
				]
			)
		);
	}
}
