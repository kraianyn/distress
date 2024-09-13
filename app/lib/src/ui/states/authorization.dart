import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app.dart';
import '../core/providers/app_state_provider.dart';
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
		final permissions = await repository.permissions(field.text);
		if (permissions != null) {
			await repository.initUser(permissions);
			ref.read(appStateNotifierProvider.notifier).set(AppState.userForm);
		}
	}
}
