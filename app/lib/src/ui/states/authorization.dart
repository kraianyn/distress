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
		final awaitingActions = useState(false);
		final codeField = useTextEditingController();

		return DescribedPage(
			title: "Доступ",
			text: "Отримання доступу до системи здійснюється "
				"за допомогою одноразового коду.",
			content: [
				TextField(
					controller: codeField,
					style: accessCodeTextStyle,
					textAlign: TextAlign.center,
					decoration: InputDecoration(
						hintText: "Код",
						hintStyle: headlineHintTextStyle
					)
				),
				verticalSpaceLarge,
				FilledButton.icon(
					icon: AppIcon.accessCode,
					label: const Text("Далі"),
					onPressed: !awaitingActions.value
						? () => _authorize(context, ref, codeField, awaitingActions)
						: null
				)
			]
		);
	}

	Future<void> _authorize(
		BuildContext context,
		WidgetRef ref,
		TextEditingController field,
		ValueNotifier<bool> awaitingActions
	) async {
		final code = field.text.trim();
		if (code.isEmpty) return;

		awaitingActions.value = true;
		final roles = await ref.usersRepository.accessCodeRoles(code);

		if (roles != null) {
			await ref.appStateNotifier.authorizeUser(roles);
		}
		else {
			ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
				content: Text("Код хибний"),
				duration: Duration(seconds: 2)
			));
			awaitingActions.value = false;
		}
	}
}
