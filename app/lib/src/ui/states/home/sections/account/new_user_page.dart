import 'package:distress/src/ui/core/app_icon.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter/services.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/user.dart';

import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/widgets/error.dart';
import 'package:distress/src/ui/core/widgets/loading.dart';


class NewUserPage extends HookWidget {
	const NewUserPage();

	@override
	Widget build(BuildContext context) {
		final roles = useState<List<Role>?>(null);

		return Scaffold(
			body: roles.value == null
				? RolesForm(roles: roles)
				: AccessCodeCreationWidget(roles.value!)
		);
	}
}


class RolesForm extends HookWidget {
	const RolesForm({required this.roles});

	final ValueNotifier<List<Role>?> roles;

	@override
	Widget build(BuildContext context) {
		final isInstructor = useRef(true);
		final canManageSchedule = useRef(false);
		final canManageUsers = useRef(false);

		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Padding(
					padding: horizontalPadding,
					child: Text("Новий користувач", style: Theme.of(context).textTheme.headlineLarge)
				),
				verticalSpaceLarge,
				RoleTile(
					title: "Інструктор",
					icon: AppIcon.instructor,
					state: isInstructor
				),
				RoleTile(
					title: "Може змінювати розклад",
					icon: AppIcon.schedule,
					state: canManageSchedule
				),
				RoleTile(
					title: "Може додавати користувачів",
					icon: AppIcon.addUser,
					state: canManageUsers
				),
				verticalSpaceLarge,
				Padding(
					padding: horizontalPadding,
					child: FilledButton.icon(
						icon: AppIcon.accessCode,
						label: const Text("Створити код доступу"),
						onPressed: () => roles.value = [
							if (isInstructor.value) Role.teaching,
							if (canManageSchedule.value) Role.managingSchedule,
							if (canManageUsers.value) Role.managingUsers
						]
					)
				)
			]
		);
	}
}

class RoleTile extends HookWidget {
	const RoleTile({
		required this.title,
		required this.icon,
		required this.state
	});

	final String title;
	final Icon icon;
	final ObjectRef<bool> state;

	@override
	Widget build(BuildContext context) {
		final currentState = useState(state.value);

		return SwitchListTile(
			title: Text(title),
			secondary: icon,
			value: currentState.value,
			onChanged: (newState) => _onSwitch(newState, currentState)
		);
	}

	void _onSwitch(bool newState, ValueNotifier<bool> currentState) {
		currentState.value = newState;
		state.value = newState;
	}
}


class AccessCodeCreationWidget extends HookConsumerWidget {
	const AccessCodeCreationWidget(this.roles);

	final List<Role> roles;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final snapshot = useFuture(useMemoized(
			() => ref.usersRepository.createAccessCode(roles)
		));

		return Padding(
			padding: paddingAround,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text("Код доступу", style: Theme.of(context).textTheme.headlineLarge),
					verticalSpaceLarge,
					_codeWidget(snapshot),
					verticalSpaceLarge,
					const Text("Передай цей код новому користувачу.")
				]
			)
		);
	}

	Widget _codeWidget(AsyncSnapshot snapshot) {
		if (snapshot.connectionState == ConnectionState.waiting) {
			return const LoadingWidget();
		}

		if (snapshot.hasData) {
			final code = snapshot.data!;
			Clipboard.setData(ClipboardData(text: code));

			return Text(code, style: accessCodeTextStyle, textAlign: TextAlign.center);
		}

		return ErrorWidget(snapshot.error!, snapshot.stackTrace);
	}
}
