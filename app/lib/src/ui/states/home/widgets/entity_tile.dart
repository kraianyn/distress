import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/extensions/build_context.dart';


class EntityTile extends StatelessWidget {
	const EntityTile({
		required this.title,
		this.subtitle,
		this.trailing,
		required this.pageBuilder
	});

	final String title;
	final String? subtitle;
	final String? trailing;
	final Widget Function(BuildContext) pageBuilder;

	@override
	Widget build(BuildContext context) {
		return ListTile(
			title: Text(title),
			subtitle: subtitle != null ? Text(subtitle!) : null,
			trailing: trailing != null ? Text(trailing!) : null,
			onTap: () => context.openPage(pageBuilder)
		);
	}
}
