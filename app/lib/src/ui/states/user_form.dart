import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/instructor.dart';

import '../core/providers/app_state.dart';
import '../core/providers/user.dart';
import '../core/providers/users_repository.dart';

import '../app.dart';
import 'home/providers/schedule_repository.dart';


class UserForm extends HookConsumerWidget {
	const UserForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeNameField = useTextEditingController();

		return Scaffold(
			appBar: AppBar(title: const Text("Надання інформації")),
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: codeNameField,
						decoration: const InputDecoration(hintText: "Позивний")
					),
					FilledButton(
						child: const Icon(Icons.send),
						onPressed: () => _addInfo(ref, codeNameField)
					)
				]
			)
		);
	}

	Future<void> _addInfo(WidgetRef ref, TextEditingController codeNameField) async {
		final codeName = codeNameField.text.trim();
		if (codeName.isEmpty) return;

		ref.read(userNotifierProvider.notifier).addInfo(codeName);
		await Future.wait([
			ref.read(usersRepositoryProvider).addUserInfo(),
			ref.read(scheduleRepositoryProvider).addInstructor(
				Instructor.created(codeName: codeName)
			)
		]);
		ref.read(appStateNotifierProvider.notifier).set(AppState.home);
	}
}
