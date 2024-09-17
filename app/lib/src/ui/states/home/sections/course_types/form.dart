import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/ui/core/app_icon.dart';

import '../../providers/courses.dart';
import '../../providers/course_types.dart';
import '../../providers/pages/course_type.dart';


class CourseTypeForm extends HookConsumerWidget {
	const CourseTypeForm([this.type]);

	final CourseType? type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: type?.name);
		final courseCountField = useTextEditingController(text: type?.courseCount.toString());

		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: nameField,
						decoration: const InputDecoration(hintText: "Назва")
					),
					TextField(
						controller: courseCountField,
						decoration: const InputDecoration(hintText: "Кількість проведених курсів")
					)
				]
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(AppIcon.confirm),
				onPressed: type == null
					? () => _add(
						context, ref, nameField.text, int.parse(courseCountField.text)
					)
					: () => _update(context, ref, nameField.text)
			)
		);
	}

	void _add(BuildContext context, WidgetRef ref, String name, int courseCount) {
		final type = CourseType.created(name: name, courseCount: courseCount);
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
