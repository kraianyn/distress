import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
	const ErrorPage(this.error);

	final Object error;

	@override
	Widget build(BuildContext context) {
		return Container(
			color: const HSLColor.fromAHSL(1, 0, 1, .8).toColor(),
			alignment: Alignment.center,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					const Icon(Icons.sentiment_dissatisfied),
					Text(error.toString())
				],
			),
		);
	}
}
