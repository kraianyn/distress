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
		final actions = useState<List<UserAction>?>(null);

		return Scaffold(
			body: actions.value == null
				? UserActionsForm(onCreateCode: (givenActions) => actions.value = givenActions)
				: AccessCodeCreationWidget(actions.value!)
		);
	}
}


class UserActionsForm extends HookWidget {
	const UserActionsForm({required this.onCreateCode});

	final void Function(List<UserAction>) onCreateCode;

	@override
	Widget build(BuildContext context) {
		final isInstructor = useRef(true);
		final canManageSchedule = useRef(false);
		final canAddUsers = useRef(false);

		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Padding(
					padding: horizontalPadding,
					child: Text("Новий користувач", style: Theme.of(context).textTheme.headlineLarge)
				),
				const ListTile(),
				UserActionTile(
					title: "Інструктор",
					icon: AppIcon.instructor,
					state: isInstructor
				),
				UserActionTile(
					title: "Може змінювати розклад",
					icon: AppIcon.schedule,
					state: canManageSchedule
				),
				UserActionTile(
					title: "Може додавати користувачів",
					icon: AppIcon.addUser,
					state: canAddUsers
				),
				const ListTile(),
				Padding(
					padding: horizontalPadding,
					child: FilledButton.icon(
						icon: AppIcon.accessCode,
						label: const Text("Створити код доступу"),
						onPressed: () => onCreateCode([
							if (isInstructor.value) UserAction.teaching,
							if (canManageSchedule.value) UserAction.managingSchedule,
							if (canAddUsers.value) UserAction.addingUsers
						])
					)
				)
			]
		);
	}
}

class UserActionTile extends HookWidget {
	const UserActionTile({
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
	const AccessCodeCreationWidget(this.actions);

	final List<UserAction> actions;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final snapshot = useFuture(useMemoized(
			() => ref.usersRepository.createAccessCode(actions)
		));

		return Padding(
			padding: padding,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text("Код доступу", style: Theme.of(context).textTheme.headlineLarge),
					const ListTile(),
					_codeWidget(snapshot),
					const ListTile(),
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
