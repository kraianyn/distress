import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/open_page.dart';

import 'new_user_page.dart';


class SettingsSection extends StatelessWidget {
	const SettingsSection();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(child: FilledButton(
				child: const Icon(Icons.person_add),
				onPressed: () => openPage(context, (_) => const NewUserPage())
			))
		);
	}
}
