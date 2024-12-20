import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/app_icon.dart';
import '../core/theme.dart';
import '../core/extensions/build_context.dart';
import '../core/extensions/providers_references.dart';
import '../core/extensions/text_editing_controller.dart';
import '../core/widgets/async_action_button.dart';
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
					style: accessCodeTextStyle,
					textAlign: TextAlign.center,
					decoration: InputDecoration(
						hintText: "Код",
						hintStyle: headlineHintTextStyle
					)
				),
				verticalSpaceLarge,
				AsyncActionButton(
					icon: AppIcon.accessCode,
					label: "Далі",
					awaitingLabel: "Перевірка",
					action: () => _authorize(context, ref, codeField)
				)
			]
		);
	}

	Future<void> _authorize(
		BuildContext context,
		WidgetRef ref,
		TextEditingController field
	) async {
		final code = field.trimmedText;
		if (code.isEmpty) return;

		final showSnackBar = context.showTextSnackBar;
		final roles = await ref.usersRepository.accessCodeRoles(code);

		if (roles != null) {
			await ref.appStateNotifier.authorizeUser(roles);
		}
		else {
			showSnackBar("Код хибний");
		}
	}
}
