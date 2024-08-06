import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/location.dart';

import '../../providers/locations.dart';


class LocationForm extends HookConsumerWidget {
	const LocationForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController();
		final linkField = useTextEditingController();

		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: nameField,
						decoration: const InputDecoration(hintText: "Назва")
					),
					TextField(
						controller: linkField,
						decoration: const InputDecoration(hintText: "Посилання")
					)
				]
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(Icons.done),
				onPressed: () => _add(context, ref, nameField.text, linkField.text)
			)
		);
	}

	void _add(BuildContext context, WidgetRef ref, String name, String link) {
		ref.read(locationsNotifierProvider.notifier).add(Location(
			id: name.replaceAll('.', '').replaceAll(' ', ''),
			name: name,
			link: link
		));
		Navigator.of(context).pop();
	}
}
