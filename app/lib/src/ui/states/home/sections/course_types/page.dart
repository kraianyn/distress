import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/extensions/quantity.dart';

import '../../providers/courses.dart';
import '../../providers/pages/course_type.dart';

import '../../widgets/course_component_page.dart';
import '../../widgets/delete_action_button.dart';
import '../../widgets/modify_action_button.dart';

import 'form.dart';


class CourseTypePage extends ConsumerWidget {
	const CourseTypePage(this.type);

	final CourseType type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final type = ref.watch(courseTypePageNotifierProvider(this.type));
		final courses = ref.courses().withType(type)?.toList();

		return CourseComponentPage(
			title: type.name,
			content: [
				ListTile(
					title: Text(type.courseCount.courses),
					leading: AppIcon.courseCount
				)
			],
			courses: courses,
			showCourseLocation: true,
			actions: [
				ModifyActionButton(formBuilder: (_) => CourseTypeForm(type)),
				DeleteActionButton(
					question: "Видалити тип курсу?",
					text: "Заплановані курси цього типу теж буде видалено.",
					delete: () => ref.courseTypesNotifier.delete(type)
				)
			]
		);
	}
}
