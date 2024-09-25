import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/ui/core/app_icon.dart';

import '../../providers/courses.dart';
import '../../providers/instructors.dart';

import '../../widgets/entity_page.dart';
import '../schedule/tile.dart';


class InstructorPage extends ConsumerWidget {
	const InstructorPage(this.instructor);

	final Instructor instructor;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider).value!;
		final relevantCourses = courses.where((c) => c.instructors.contains(instructor));

		return EntityPage(
			content: [
				EntityTitle(instructor.codeName),
				const ListTile(),
				...relevantCourses.map(CourseTile.new)
			],
			actions: [
				IconButton(
					icon: AppIcon.delete,
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).removeInstructor(instructor);
		ref.read(instructorsNotifierProvider.notifier).delete(instructor);
		Navigator.pop(context);
	}
}
