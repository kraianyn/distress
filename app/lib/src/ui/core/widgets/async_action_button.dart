import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../app_icon.dart';


class AsyncActionButton extends HookWidget {
	const AsyncActionButton({
		required this.icon,
		required this.label,
		required this.awaitingLabel,
		required this.action
	});

	final Icon icon;
	final String label;
	final String awaitingLabel;
	final Future<void> Function() action;

	@override
	Widget build(BuildContext context) {
		final awaiting = useState(false);

		return FilledButton.icon(
			icon: AppIcon.accessCode,
			label: !awaiting.value ? Text(label) : Text('$awaitingLabel...'),
			onPressed: !awaiting.value
				? () async {
					awaiting.value = true;
					await action();
					awaiting.value = false;
				}
				: null
		);
	}
}
