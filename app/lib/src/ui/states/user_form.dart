import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/instructor.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../app.dart';
import '../core/app_icon.dart';
import '../core/theme.dart';


class UserForm extends HookConsumerWidget {
	const UserForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeNameField = useTextEditingController();

		return Scaffold(
			appBar: AppBar(title: const Text("Надання інформації")),
			body: Padding(
				padding: padding,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						TextField(
							controller: codeNameField,
							style: Theme.of(context).textTheme.titleMedium,
							decoration: const InputDecoration(
								hintText: "Позивний",
								icon: AppIcon.account
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

		ref.userNotifier.addInfo(codeName);
		final user = ref.user(watch: false)!;
		await Future.wait([
			ref.usersRepository().addUserInfo(),
			if (user.isInstructor) ref.instructorsNotifier.add(
				Instructor(id: user.id, codeName: codeName)
			)
		]);
		ref.appStateNotifier.set(AppState.home);
	}
}
