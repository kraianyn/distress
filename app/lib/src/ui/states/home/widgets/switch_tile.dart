import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class SwitchTile extends HookWidget {
	const SwitchTile({
		required this.title,
		required this.icon,
		required this.stateObject
	});

	final String title;
	final Icon icon;
	final ObjectRef<bool> stateObject;

	@override
	Widget build(BuildContext context) {
		final state = useState(stateObject.value);

		return SwitchListTile(
			title: Text(title),
			secondary: icon,
			value: state.value,
			onChanged: (newState) {
				state.value = newState;
				stateObject.value = newState;
			}
		);
	}
}
