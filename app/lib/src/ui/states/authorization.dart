import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/user.dart';
import 'package:distress/src/domain/providers/user.dart';

import '../app.dart';

import '../core/providers/app_state.dart';
import '../core/providers/users_repository.dart';


class Authorization extends HookConsumerWidget {
	const Authorization();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final field = useTextEditingController();

		return Scaffold(
			appBar: AppBar(title: const Text("Доступ")),
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					TextField(controller: field),
					FilledButton(
						child: const Icon(Icons.send),
						onPressed: () => _handleCode(ref, field)
					)
				]
			)
		);
	}

	Future<void> _handleCode(WidgetRef ref, TextEditingController field) async {
		final repository = ref.read(usersRepositoryProvider);
		final permissions = await repository.permissions(field.text.trim());
		if (permissions != null) {
			final user = User(
				id: ref.read(userIdNotifierProvider)!,
				permissions: permissions
			);
			await repository.initUser(user);
			ref.read(appStateNotifierProvider.notifier).set(AppState.userForm);
		}
	}
}
