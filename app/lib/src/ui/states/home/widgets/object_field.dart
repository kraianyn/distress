import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/theme.dart';


class ObjectField extends StatelessWidget {
	const ObjectField({
		required this.controller,
		required this.name,
		this.icon,
		this.isHeadline = false,
		required this.onTap
	});

	final TextEditingController controller;
	final String name;
	final Icon? icon;
	final bool isHeadline;
	final void Function() onTap;

	@override
	Widget build(BuildContext context) {
		final textTheme = Theme.of(context).textTheme;
		final textStyle = !isHeadline ? textTheme.titleMedium : textTheme.headlineMedium;

		return TextField(
			controller: controller,
			style: textStyle,
			decoration: InputDecoration(
				hintText: name,
				icon: icon,
				hintStyle: !isHeadline ? null : headlineHintTextStyle
			),
			readOnly: true,
			onTap: onTap
		);
	}
}
