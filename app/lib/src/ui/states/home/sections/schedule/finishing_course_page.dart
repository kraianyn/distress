import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/extensions/text_editing_controller.dart';
import 'package:distress/src/ui/core/widgets/async_action_button.dart';

import '../../providers/course_types.dart';


class FinishingCoursePage extends HookConsumerWidget {
	const FinishingCoursePage(this.course);

	final Course course;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final studentCountField = useTextEditingController();

		return Scaffold(body: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Text(
					"Закінчення курсу",
					style: Theme.of(context).textTheme.headlineMedium
				),
				verticalSpaceLarge,
				TextField(
					controller: studentCountField,
					style: Theme.of(context).textTheme.titleMedium,
					decoration: const InputDecoration(
						hintText: "Кількість курсантів",
						icon: AppIcon.students
					)
				),
				verticalSpaceLarge,
				AsyncActionButton(
					icon: AppIcon.confirm,
					label: "Закінчити курс",
					awaitingLabel: "Закінчення",
					action: () => _finishCourse(context, ref, studentCountField)
				)
			]
		).withHorizontalPadding);
	}

	Future<void> _finishCourse(
		BuildContext context,
		WidgetRef ref,
		TextEditingController field
	) async {
		final studentCount = field.number;
		if (studentCount == null) return;

		final showSnackBar = context.showTextSnackBar;
		await ref.coursesNotifier.finish(course, studentCount: studentCount);

		ref.invalidate(courseTypesNotifierProvider);
		showSnackBar("Курс закінчено");
		if (context.mounted) context.closePage();
	}
}
