import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../date_time.dart';


class CourseForm extends HookConsumerWidget {
	const CourseForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final typeField = useTextEditingController();
		final dateField = useTextEditingController();
		final locationField = useTextEditingController();
		final instructorsField = useTextEditingController();
		final noteField = useTextEditingController();

		final date = useRef<DateTime?>(null);

		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: typeField,
						decoration: const InputDecoration(hintText: "Курс"),
						readOnly: true,
					),
					TextField(
						controller: dateField,
						decoration: const InputDecoration(hintText: "Дата"),
						readOnly: true,
						onTap: () => _askDate(context, date, dateField),
					),
					TextField(
						controller: locationField,
						decoration: const InputDecoration(hintText: "Локація"),
						readOnly: true,
					),
					TextField(
						controller: instructorsField,
						decoration: const InputDecoration(hintText: "Інструктори"),
						readOnly: true,
					),
					TextField(
						controller: noteField,
						decoration: const InputDecoration(hintText: "Нотатка")
					)
				]
			),
			floatingActionButton: FloatingActionButton(
				onPressed: () => _add,
				child: const Icon(Icons.done)
			)
		);
	}

	Future<void> _askDate(
		BuildContext context,
		ObjectRef<DateTime?> object,
		TextEditingController field
	) async {
		final now = DateTime.now();
		object.value = await showDatePicker(
			context: context,
			initialDate: object.value,
			firstDate: now,
			lastDate: now.add(const Duration(days: 365))
		);
		field.text = object.value != null ? object.value!.dateString : '';
	}

	void _add() {

	}
}
