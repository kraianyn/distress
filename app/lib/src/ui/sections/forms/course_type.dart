import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course_type.dart';

import '../../providers/courses.dart';
import '../../providers/course_types.dart';
import '../../providers/pages/course_type.dart';


class CourseTypeForm extends HookConsumerWidget {
	const CourseTypeForm([this.type]);

	final CourseType? type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: type?.name);

		return Scaffold(
			body: Center(
				child: TextField(
					controller: nameField,
					decoration: const InputDecoration(hintText: "Назва")
				)
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(Icons.done),
				onPressed: () => type == null ?
					_add(context, ref, nameField.text) :
					_update(context, ref, nameField.text)
			)
		);
	}

	void _add(BuildContext context, WidgetRef ref, String name) {
		final type = CourseType.created(name: name);
		ref.read(courseTypesNotifierProvider.notifier).add(type);
		Navigator.of(context).pop();
	}

	void _update(BuildContext context, WidgetRef ref, String name) {
		if (name == type!.name) return;

		final updatedType = type!.copyWith(name: name);
		ref.read(courseTypePageNotifierProvider(type!).notifier).update(updatedType);
		ref.read(courseTypesNotifierProvider.notifier).updateType(updatedType);
		ref.read(coursesNotifierProvider.notifier).updateType(updatedType);
		Navigator.of(context).pop();
	}
}
