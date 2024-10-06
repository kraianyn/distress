import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/navigation_context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../providers/courses.dart';
import '../../providers/pages/course_type.dart';
import '../../widgets/course_component_page.dart';

import 'form.dart';


class CourseTypePage extends ConsumerWidget {
	const CourseTypePage(this.type);

	final CourseType type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final type = ref.watch(courseTypePageNotifierProvider(this.type));
		final courses = ref.courses().ofType(type)?.toList();

		return CourseComponentPage(
			title: type.name,
			content: [
				ListTile(
					title: Text("${type.courseCount} курсів"),
					leading: AppIcon.courseCount
				)
			],
			courses: courses,
			showCourseLocation: true,
			actions: [
				IconButton(
					icon: AppIcon.modify,
					tooltip: "Змінити",
					onPressed: () => context.openPage((_) => CourseTypeForm(type))
				),
				IconButton(
					icon: AppIcon.delete,
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.courseTypesNotifier.delete(type);
		Navigator.pop(context);
	}
}
