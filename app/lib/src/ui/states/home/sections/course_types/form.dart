import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/extensions/text_editing_controller.dart';

import '../../widgets/entity_form.dart';
import '../../widgets/switch_tile.dart';


class CourseTypeForm extends HookConsumerWidget {
	const CourseTypeForm([this.type]);

	final CourseType? type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final nameField = useTextEditingController(text: type?.name);
		final courseCountField = useTextEditingController(
			text: type?.courseCount.toString()
		);
		final studentCountField = useTextEditingController(
			text: type?.studentCount.toString()
		);
		final certificatesAreIssuedByTrainingCenter = useRef(true);

		final textTheme = Theme.of(context).textTheme;

		return EntityForm(
			adding: type == null,
			action: type == null
				? () => _add(
					context,
					ref,
					nameField,
					courseCountField,
					studentCountField,
					certificatesAreIssuedByTrainingCenter
				)
				: () => _update(context, ref, nameField),
			content: [
				...[
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
							icon: AppIcon.number
						)
					),
					if (type == null) TextField(
						controller: studentCountField,
						style: textTheme.titleMedium,
						decoration: const InputDecoration(
							hintText: "Кількість навчених курсантів",
							icon: AppIcon.students
						)
					)
				].map((w) => w.withHorizontalPadding),
				verticalSpaceLarge,
				if (type == null) SwitchTile(
					title: "Сертифікати від нашого центру",
					icon: AppIcon.certificate,
					stateObject: certificatesAreIssuedByTrainingCenter
				)
			]
		);
	}

	void _add(
		BuildContext context,
		WidgetRef ref,
		TextEditingController nameField,
		TextEditingController courseCountField,
		TextEditingController studentCountField,
		ObjectRef<bool> certificatesAreIssuedByTrainingCenter
	) {
		final name = nameField.trimmedText;
		final courseCount = courseCountField.number,
			studentCount = studentCountField.number;
		if (name.isEmpty || courseCount == null || studentCount == null) return;

		ref.courseTypesNotifier.add(CourseType.added(
			name: name,
			courseCount: courseCount,
			studentCount: studentCount,
			certificatesAreIssuedByTrainingCenter: certificatesAreIssuedByTrainingCenter.value
		));
		context.closePage(type);
	}

	void _update(BuildContext context, WidgetRef ref, TextEditingController nameField) {
		final name = nameField.trimmedText;
		if (name != type!.name) {
			ref.courseTypesNotifier.updateType(type!.copyWith(name: name));
		}
		context.closePage();
	}
}
