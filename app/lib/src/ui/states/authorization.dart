import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/app_icon.dart';
import '../core/theme.dart';
import '../core/extensions/providers_references.dart';
import '../core/widgets/described_page.dart';


class Authorization extends HookConsumerWidget {
	const Authorization();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeField = useTextEditingController();

		return DescribedPage(
			title: "Доступ",
			text: "Отримання доступу до системи здійснюється "
				"за допомогою одноразового коду.",
			content: [
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
				FilledButton.icon(
					icon: AppIcon.accessCode,
					label: Text("Далі"),
					onPressed: () => _handleCode(ref, codeField)
				)
			]
		);
	}

	Future<void> _handleCode(WidgetRef ref, TextEditingController field) async {
		final code = field.text.trim();
		if (code.isEmpty) return;

		final actions = await ref.usersRepository.accessCodeUserActions(code);
		if (actions != null) {
			await ref.appStateNotifier.authorizeUser(actions);
		}
	}
}
