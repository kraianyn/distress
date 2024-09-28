import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/extensions/navigation_context.dart';


class EntityTile extends StatelessWidget {
	const EntityTile({
		required this.title,
		this.trailing,
		required this.pageBuilder
	});

	final String title;
	final String? trailing;
	final Widget Function(BuildContext) pageBuilder;

	@override
	Widget build(BuildContext context) {
		return ListTile(
			title: Text(title),
			trailing: trailing != null ? Text(trailing!) : null,
			onTap: () => context.openPage(pageBuilder)
		);
	}
}
