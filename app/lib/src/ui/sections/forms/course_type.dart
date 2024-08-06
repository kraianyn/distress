import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course_type.dart';

import '../../providers/course_types.dart';


class CourseTypeForm extends HookConsumerWidget {
	const CourseTypeForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController();

		return Scaffold(
			body: Center(
				child: TextField(
					controller: nameField,
					decoration: const InputDecoration(hintText: "Назва")
				)
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(Icons.done),
				onPressed: () => _add(context, ref, nameField)
			)
		);
	}

	void _add(BuildContext context, WidgetRef ref, TextEditingController nameField) {
		final name = nameField.text;
		ref.read(courseTypesNotifierProvider.notifier).add(CourseType(
			id: name.replaceAll(' ', '').toLowerCase(),
			name: name
		));
		Navigator.of(context).pop();
	}
}
