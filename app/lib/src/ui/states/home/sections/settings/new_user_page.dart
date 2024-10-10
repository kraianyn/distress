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
			appBar: AppBar(
				title: const Text("Додання користувача"),
				automaticallyImplyLeading: false
			),
			body: actions.value == null
				? ActionsForm(onCreateCode: (givenActions) => actions.value = givenActions)
				: AccessCodeCreationWidget(actions.value!)
		);
	}
}

class ActionsForm extends HookWidget {
	const ActionsForm({required this.onCreateCode});

	final void Function(List<UserAction>) onCreateCode;

	@override
	Widget build(BuildContext context) {
		final isInstructor = useRef(true);
		final canManageSchedule = useRef(false);
		final canAddUsers = useRef(false);

		return Column (
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				ActionTile(title: "Інструктор", state: isInstructor),
				ActionTile(title: "Може змінювати розклад", state: canManageSchedule),
				ActionTile(title: "Може додавати користувачів", state: canAddUsers),
				const ListTile(),
				FilledButton(
					child: const Text("Створити код"),
					onPressed: () => onCreateCode([
						if (isInstructor.value) UserAction.teaching,
						if (canManageSchedule.value) UserAction.managingSchedule,
						if (canAddUsers.value) UserAction.addingUsers,
					])
				)
			]
		);
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
			() => ref.usersRepository.createAccessCode(actions)
		));

		if (snapshot.connectionState == ConnectionState.waiting) {
			return const LoadingWidget();
		}

		if (snapshot.hasData) {
			final code = snapshot.data!;
			Clipboard.setData(ClipboardData(text: code));

			return Center(child: Text(code, style: codeTextStyle));
		}

		return ErrorWidget(snapshot.error!, snapshot.stackTrace);
	}
}
