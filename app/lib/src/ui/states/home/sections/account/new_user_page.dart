import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter/services.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/user.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/widgets/async_action_button.dart';

import '../../widgets/switch_tile.dart';


class NewUserPage extends HookWidget {
	const NewUserPage();

	@override
	Widget build(BuildContext context) {
		final code = useState<String?>(null);

		return Scaffold(
			body: code.value == null
				? RolesForm(code: code)
				: AccessCodeWidget(code.value!)
		);
	}
}

class RolesForm extends HookConsumerWidget {
	const RolesForm({required this.code});

	final ValueNotifier<String?> code;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final isInstructor = useRef(true);
		final canManageSchedule = useRef(false);
		final canManageUsers = useRef(false);

		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Text(
					"Новий користувач",
					style: Theme.of(context).textTheme.headlineLarge
				).withHorizontalPadding,
				verticalSpaceLarge,
				SwitchTile(
					title: "Інструктор",
					icon: AppIcon.instructor,
					stateObject: isInstructor
				),
				SwitchTile(
					title: "Може змінювати розклад",
					icon: AppIcon.schedule,
					stateObject: canManageSchedule
				),
				SwitchTile(
					title: "Може додавати користувачів",
					icon: AppIcon.addUser,
					stateObject: canManageUsers
				),
				verticalSpaceLarge,
				AsyncActionButton(
					icon: AppIcon.accessCode,
					label: "Створити код доступу",
					awaitingLabel: "Створення",
					action: () => _createCode(
						ref,
						[
							if (isInstructor.value) Role.teaching,
							if (canManageSchedule.value) Role.managingSchedule,
							if (canManageUsers.value) Role.managingUsers
						]
					)
				).withHorizontalPadding
			]
		);
	}

	Future<void> _createCode(
		WidgetRef ref,
		List<Role> roles
	) async {
		code.value = await ref.usersRepository.createAccessCode(roles);
		Clipboard.setData(ClipboardData(text: code.value!));
	}
}

class AccessCodeWidget extends StatelessWidget {
	const AccessCodeWidget(this.code);

	final String code;

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Text("Код доступу", style: Theme.of(context).textTheme.headlineLarge),
				verticalSpaceLarge,
				Text(code, style: accessCodeTextStyle, textAlign: TextAlign.center),
				verticalSpaceLarge,
				const Text("Передай цей код новому користувачу.")
			]
		).withHorizontalPadding;
	}
}
