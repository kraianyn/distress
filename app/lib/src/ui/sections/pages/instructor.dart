import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/instructor.dart';

import '../../providers/courses.dart';
import '../../providers/instructors.dart';

import '../../widgets/tiles/course.dart';
import 'entity.dart';


class InstructorPage extends ConsumerWidget {
	const InstructorPage(this.instructor);

	final Instructor instructor;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider).value!;
		final relevantCourses = courses.where((c) => c.instructors.contains(instructor));

		return EntityPage(
			content: [
				Text(instructor.codeName),
				...relevantCourses.map(CourseTile.new)
			],
			actions: [
				IconButton(
					icon: const Icon(Icons.delete),
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).removeInstructor(instructor);
		ref.read(instructorsNotifierProvider.notifier).delete(instructor);
		Navigator.of(context).pop();
	}
}
