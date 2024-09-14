import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app.dart';

import '../core/providers/app_state.dart';
import '../core/providers/users_repository.dart';


class UserForm extends HookConsumerWidget {
	const UserForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeNameField = useTextEditingController();

		return Scaffold(
			appBar: AppBar(title: const Text("Інформація")),
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: codeNameField,
						decoration: const InputDecoration(hintText: "Позивний")
					),
					FilledButton(
						child: const Icon(Icons.send),
						onPressed: () => _handleInfo(ref, codeNameField.text)
					)
				]
			)
		);
	}

	Future<void> _handleInfo(WidgetRef ref, String codeName) async {
		await ref.read(usersRepositoryProvider).setUserInfo(codeName);
		ref.read(appStateNotifierProvider.notifier).set(AppState.home);
	}
}
