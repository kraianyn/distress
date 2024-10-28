import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/app_icon.dart';
import '../core/theme.dart';
import '../core/extensions/build_context.dart';
import '../core/extensions/providers_references.dart';
import '../core/extensions/text_editing_controller.dart';
import '../core/widgets/described_page.dart';


class Authorization extends HookConsumerWidget {
	const Authorization();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeField = useTextEditingController();
		final awaitingRoles = useState(false);

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
					onPressed: !awaitingRoles.value
						? () => _authorize(context, ref, codeField, awaitingRoles)
						: null
				)
			]
		);
	}

	Future<void> _authorize(
		BuildContext context,
		WidgetRef ref,
		TextEditingController field,
		ValueNotifier<bool> awaitingRoles
	) async {
		final code = field.trimmedText;
		if (code.isEmpty) return;

		final showSnackBar = context.showSnackBar;
		awaitingRoles.value = true;
		final roles = await ref.usersRepository.accessCodeRoles(code);

		if (roles != null) {
			await ref.appStateNotifier.authorizeUser(roles);
		}
		else {
			showSnackBar("Код хибний");
			awaitingRoles.value = false;
		}
	}
}
