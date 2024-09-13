import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/open_page.dart';


class EntityTitle extends StatelessWidget {
	const EntityTitle(this.text, {this.pageBuilder});

	final String text;
	final Widget Function(BuildContext)? pageBuilder;

	@override
	Widget build(BuildContext context) {
		return ListTile(
			title: Text(text, style: Theme.of(context).textTheme.headlineMedium),
			onTap: pageBuilder == null ? null : () => openPage(context, pageBuilder!)
		);
	}
}
