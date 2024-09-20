import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app.dart';

import '../core/providers/app_state.dart';
import '../core/providers/user.dart';
import '../core/providers/users_repository.dart';


class Authorization extends HookConsumerWidget {
	const Authorization();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeField = useTextEditingController();

		return Scaffold(
			appBar: AppBar(title: const Text("Отримання доступу")),
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(controller: codeField),
					FilledButton(
						child: const Icon(Icons.send),
						onPressed: () => _handleCode(ref, codeField)
					)
				]
			)
		);
	}

	Future<void> _handleCode(WidgetRef ref, TextEditingController field) async {
		final code = field.text.trim();
		if (code.isEmpty) return;

		final actions = await ref.read(usersRepositoryProvider).newUserActions(code);
		if (actions != null) {
			ref.read(userNotifierProvider.notifier).addActions(actions);
			await ref.read(usersRepositoryProvider).initUser();
			ref.read(appStateNotifierProvider.notifier).set(AppState.userForm);
		}
	}
}
