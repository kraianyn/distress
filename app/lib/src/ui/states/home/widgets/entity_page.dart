import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/open_page.dart';
import 'package:distress/src/ui/core/providers/user.dart';


class EntityPage extends ConsumerWidget {
	const EntityPage({
		required this.content,
		required this.actions
	});

	final List<Widget> content;
	final List<Widget> actions;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final userCanModify = ref.watch(userNotifierProvider)!.canManageSchedule;

		return Scaffold(body: Stack(
			children: [
				Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: content
				),
				if (userCanModify) SafeArea(
					child: Row(
						mainAxisAlignment: MainAxisAlignment.end,
						children: actions
					)
				)
			]	
		));
	}
}

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
