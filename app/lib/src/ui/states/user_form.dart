import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/instructor.dart';

import '../app.dart';
import '../core/app_icon.dart';
import '../core/theme.dart';

import '../core/providers/app_state.dart';
import '../core/providers/user.dart';
import '../core/providers/users_repository.dart';

import 'home/providers/schedule_repository.dart';


class UserForm extends HookConsumerWidget {
	const UserForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeNameField = useTextEditingController();

		return Scaffold(
			appBar: AppBar(title: const Text("Надання інформації")),
			body: Padding(
				padding: const EdgeInsets.all(paddingSize),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						TextField(
							controller: codeNameField,
							style: Theme.of(context).textTheme.titleMedium,
							decoration: const InputDecoration(
								hintText: "Позивний",
								icon: Icon(AppIcon.account)
							)
						),
						const ListTile(),
						FilledButton(
							child: const Icon(Icons.send),
							onPressed: () => _addInfo(ref, codeNameField)
						)
					]
				)
			)
		);
	}

	Future<void> _addInfo(WidgetRef ref, TextEditingController codeNameField) async {
		final codeName = codeNameField.text.trim();
		if (codeName.isEmpty) return;

		ref.read(userNotifierProvider.notifier).addInfo(codeName);
		final user = ref.read(userNotifierProvider)!;
		await Future.wait([
			ref.read(usersRepositoryProvider).addUserInfo(),
			if (user.isInstructor) ref.read(scheduleRepositoryProvider).addInstructor(
				Instructor(id: user.id, codeName: codeName)
			)
		]);
		ref.read(appStateNotifierProvider.notifier).set(AppState.home);
	}
}
