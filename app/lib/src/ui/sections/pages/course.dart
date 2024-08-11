import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course.dart';

import '../../open_page.dart';
import '../../date_time.dart';

import '../../providers/courses.dart';
import '../../providers/pages/course.dart';

import '../forms/course.dart';
import 'entity.dart';


class CoursePage extends ConsumerWidget {
	const CoursePage(this.course);

	final Course course;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final course = ref.watch(coursePageNotifierProvider(this.course));

		return EntityPage(
			content: [
				Text(course.type.name),
				Text(course.date.dateString),
				Text(course.location.name),
				Text(course.instructors.join(', ')),
				if (course.note != null) Text(course.note!)
			],
			actions: [
				IconButton(
					icon: const Icon(Icons.edit),
					tooltip: "Змінити",
					onPressed: () => openPage(context, (_) => CourseForm(course))
				),
				IconButton(
					icon: const Icon(Icons.event_busy),
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).delete(course);
		Navigator.of(context).pop();
	}
}
