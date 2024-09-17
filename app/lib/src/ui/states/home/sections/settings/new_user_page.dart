import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/user.dart';
import 'package:distress/src/ui/core/providers/users_repository.dart';

import '../../widgets/error_page.dart';
import '../../widgets/loading_page.dart';


class NewUserPage extends HookWidget {
	const NewUserPage();

	@override
	Widget build(BuildContext context) {
		final showForm = useState(true);
		final actions = useRef(<UserAction>[]);

		return Scaffold(
			appBar: AppBar(
				title: const Text("Додання користувача"),
				automaticallyImplyLeading: false
			),
			body: showForm.value
				? UserActionsForm(
					actions: actions,
					onCreateCode: () => showForm.value = false
				)
				: AccessCodeCreationWidget(actions.value)
		);
	}
}

class UserActionsForm extends HookWidget {
	const UserActionsForm({
		required this.actions,
		required this.onCreateCode
	});

	final ObjectRef<List<UserAction>> actions;
	final void Function() onCreateCode;

	@override
	Widget build(BuildContext context) {
		final isInstructor = useRef(true);
		final canManageSchedule = useRef(false);

		return Column (
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				ActionTile(title: "Інструктор", state: isInstructor),
				ActionTile(title: "Може змінювати розклад", state: canManageSchedule,),
				FilledButton(
					child: const Text("Створити код"),
					onPressed: () => _create(isInstructor.value, canManageSchedule.value)
				)
			]
		);
	}

	void _create(bool isInstructor, bool canManageSchedule) {
		actions.value = [
			if (isInstructor) UserAction.teaching,
			if (canManageSchedule) UserAction.managingSchedule
		];
		onCreateCode();
	}
}

class ActionTile extends HookWidget {
	const ActionTile({
		required this.title,
		required this.state
	});

	final String title;
	final ObjectRef<bool> state;

	@override
	Widget build(BuildContext context) {
		final currentState = useState(state.value);

		return SwitchListTile(
			title: Text(title),
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
			() => ref.read(usersRepositoryProvider).createAccessCode(actions)
		));

		if (snapshot.connectionState == ConnectionState.waiting) {
			return const LoadingPage();
		}

		final textStyle = Theme.of(context).textTheme.headlineMedium!;
		if (snapshot.hasData) {
			final code = snapshot.data!;
			Clipboard.setData(ClipboardData(text: code));
			return Center(child: Text(
				code,
				style: textStyle.copyWith(letterSpacing: textStyle.fontSize! / 2),
			));
		}

		return ErrorPage(snapshot.error!);
	}
}
