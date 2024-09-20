import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';

import '../../providers/courses.dart';
import '../../providers/course_types.dart';
import '../../providers/pages/course_type.dart';

import '../../widgets/entity_form.dart';


class CourseTypeForm extends HookConsumerWidget {
	const CourseTypeForm([this.type]);

	final CourseType? type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: type?.name);
		final courseCountField = useTextEditingController(text: type?.courseCount.toString());

		return EntityForm(
			content: [
				TextField(
					controller: nameField,
					decoration: InputDecoration(
						hintText: "Назва",
						hintStyle: headlineHintTextStyle
					)
				),
				if (type == null) TextField(
					controller: courseCountField,
					decoration: const InputDecoration(
						hintText: "Кількість проведених курсів",
						icon: Icon(AppIcon.courseCount)
					)
				)
			],
			onConfirm: type == null
				? () => _add(context, ref, nameField, courseCountField)
				: () => _update(context, ref, nameField)
		);
	}

	void _add(
		BuildContext context,
		WidgetRef ref,
		TextEditingController nameField,
		TextEditingController courseCountField
	) {
		final name = nameField.text.trim();
		final courseCount = int.tryParse(courseCountField.text);
		if (name.isEmpty || courseCount == null) return;

		final type = CourseType.added(name: name, courseCount: courseCount);
		ref.read(courseTypesNotifierProvider.notifier).add(type);
		Navigator.pop(context);
	}

	void _update(BuildContext context, WidgetRef ref, TextEditingController nameField) {
		final name = nameField.text.trim();
		if (name == type!.name) return;

		final updatedType = type!.copyWith(name: name);
		ref.read(courseTypePageNotifierProvider(type!).notifier).update(updatedType);
		ref.read(courseTypesNotifierProvider.notifier).updateType(updatedType);
		ref.read(coursesNotifierProvider.notifier).updateType(updatedType);
		Navigator.pop(context);
	}
}
