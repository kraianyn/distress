import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';

import '../sections/section.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
	const HomeAppBar({required this.context, required this.section});

	final BuildContext context;
	final Section section;
	static const double lineHeight = 2;

	@override
	Widget build(BuildContext context) {
		return SafeArea(child: Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(
					section.name,
					style: Theme.of(context).textTheme.headlineLarge
				).withPaddingAround,
				Container(
					height: lineHeight,
					color: Colors.black
				).withHorizontalPadding
			]
		));
	}

	@override
	Size get preferredSize {
		final textStyle = Theme.of(context).textTheme.headlineLarge!;
		final textHeight = textStyle.fontSize! * textStyle.height!;
		return Size.fromHeight(textHeight + paddingSize * 2 + lineHeight);
	}
}
