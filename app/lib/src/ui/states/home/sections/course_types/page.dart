import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/open_page.dart';

import '../../providers/course_types.dart';
import '../../providers/courses.dart';
import '../../providers/pages/course_type.dart';

import '../../widgets/entity_page.dart';
import '../schedule/tile.dart';
import 'form.dart';


class CourseTypePage extends ConsumerWidget {
	const CourseTypePage(this.type);

	final CourseType type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final type = ref.watch(courseTypePageNotifierProvider(this.type));
		final courses = ref.watch(coursesNotifierProvider).value?.where(
			(course) => course.type == type
		);

		return EntityPage(
			content: [
				EntityTitle(type.name),
				ListTile(
					title: Text("${type.courseCount} курсів"),
					leading: AppIcon.courseCount
				),
				if (courses != null) ...[
					const ListTile(),
					...courses.map((course) => CourseTile(
						course,
						title: course.location.name
					))
				]
			],
			actions: [
				IconButton(
					icon: AppIcon.change,
					tooltip: "Змінити",
					onPressed: () => openPage(context, (_) => CourseTypeForm(type))
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
		ref.read(coursesNotifierProvider.notifier).deleteWithType(type);
		ref.read(courseTypesNotifierProvider.notifier).delete(type);
		Navigator.pop(context);
	}
}
