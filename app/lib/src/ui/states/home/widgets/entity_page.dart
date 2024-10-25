import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';


class EntityPage extends ConsumerWidget {
	const EntityPage({
		required this.content,
		this.actions = const []
	});

	final List<Widget> content;
	final List<Widget> actions;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final userCanModify = ref.user()!.canManageSchedule;

		return Scaffold(body: Stack(
			children: [
				Center(child: ListView(
					shrinkWrap: true,
					children: [
						verticalSpaceLarge,
						...content,
						verticalSpaceLarge
					]
				)),
				if (actions.isNotEmpty && userCanModify) SafeArea(
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
			onTap: pageBuilder == null ? null : () => context.openPage(pageBuilder!)
		);
	}
}
