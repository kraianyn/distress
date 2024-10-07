import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/theme.dart';
import '../core/extensions/providers_references.dart';


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
					TextField(
						controller: codeField,
						style: codeTextStyle,
						textAlign: TextAlign.center,
						decoration: InputDecoration(
							hintText: "Код",
							hintStyle: headlineHintTextStyle
						)
					),
					const ListTile(),
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

		final actions = await ref.usersRepository.newUserActions(code);
		if (actions != null) {
			await ref.appStateNotifier.authorizeUser(actions);
		}
	}
}
