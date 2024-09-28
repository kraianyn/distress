import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/app_icon.dart';
import '../core/theme.dart';
import '../core/extensions/providers_references.dart';


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
		if (codeName.isNotEmpty) {
			await ref.appStateNotifier.saveUserInfo(codeName);
		}
	}
}
