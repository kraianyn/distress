import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/navigation_context.dart';


class DeleteActionButton extends StatelessWidget {
	const DeleteActionButton({
		required this.title,
		this.text,
		required this.delete
	});

	final String title;
	final String? text;
	final void Function() delete;

	@override
	Widget build(BuildContext context) {
		return IconButton(
			icon: AppIcon.delete,
			tooltip: "Видалити",
			onPressed: () => showModalBottomSheet<bool>(
				context: context,
				builder: (context) => Padding(
					padding: padding,
					child: Column(
						mainAxisSize: MainAxisSize.min,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(title, style: Theme.of(context).textTheme.headlineSmall),
							if (text != null) ...[
								verticalSpaceSmall,
								Text(text!, style: Theme.of(context).textTheme.bodyMedium)
							],
							verticalSpaceMedium,
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceAround,
								children: [
									FilledButton(
										child: Text("Так"),
										onPressed: () {
											delete();
											context..closePage()..closePage();
										}
									),
									FilledButton(
										child: Text("Ні"),
										onPressed: context.closePage
									)
								]
							)
						]
					)
				)
			)
		);
	}
}
