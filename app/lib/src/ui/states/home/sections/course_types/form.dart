import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../providers/pages/course_type.dart';
import '../../widgets/entity_form.dart';


class CourseTypeForm extends HookConsumerWidget {
	const CourseTypeForm([this.type]);

	final CourseType? type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: type?.name);
		final courseCountField = useTextEditingController(text: type?.courseCount.toString());

		final textTheme = Theme.of(context).textTheme;

		return EntityForm(
			content: [
				TextField(
					controller: nameField,
					style: textTheme.headlineMedium,
					decoration: InputDecoration(
						hintText: "Назва",
						hintStyle: headlineHintTextStyle
					)
				),
				if (type == null) TextField(
					controller: courseCountField,
					style: textTheme.titleMedium,
					decoration: const InputDecoration(
						hintText: "Кількість проведених курсів",
						icon: AppIcon.courseCount
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
		ref.courseTypesNotifier.add(type);
		Navigator.pop(context, type);
	}

	void _update(BuildContext context, WidgetRef ref, TextEditingController nameField) {
		final name = nameField.text.trim();
		if (name != type!.name) {
			final updatedType = type!.copyWith(name: name);
			ref.read(courseTypePageNotifierProvider(type!).notifier).update(updatedType);
			ref.courseTypesNotifier.updateType(updatedType);
		}
		Navigator.pop(context);
	}
}
