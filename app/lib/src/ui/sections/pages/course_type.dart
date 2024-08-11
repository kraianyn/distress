import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course_type.dart';

import '../../providers/course_types.dart';
import '../../providers/courses.dart';
import '../../providers/pages/course_type.dart';

import '../../open_page.dart';
import '../../widgets/course_tile.dart';

import '../forms/course_type.dart';
import 'entity.dart';


class CourseTypePage extends ConsumerWidget {
	const CourseTypePage(this.type);

	final CourseType type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final type = ref.watch(courseTypePageNotifierProvider(this.type));
		final courses = ref.watch(coursesNotifierProvider).value!;
		final relevantCourses = courses.where((c) => c.type == type);

		return EntityPage(
			content: [
				Text(type.name),
				...relevantCourses.map(
					(course) => CourseTile(course, title: course.location.name)
				)
			],
			actions: [
				IconButton(
					icon: const Icon(Icons.edit),
					tooltip: "Змінити",
					onPressed: () => openPage(context, (context) => CourseTypeForm(type))
				),
				IconButton(
					icon: const Icon(Icons.delete),
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).deleteWithType(type);
		ref.read(courseTypesNotifierProvider.notifier).delete(type);
		Navigator.of(context).pop();
	}
}
