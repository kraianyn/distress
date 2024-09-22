import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/instructor.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/open_page.dart';
import 'package:distress/src/ui/core/date_time.dart';

import '../../providers/courses.dart';
import '../../providers/pages/course.dart';

import '../../widgets/entity_page.dart';
import '../course_types/page.dart';
import '../instructors/page.dart';

import 'form.dart';


class CoursePage extends ConsumerWidget {
	const CoursePage(this.course);

	final Course course;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final course = ref.watch(coursePageNotifierProvider(this.course));

		return EntityPage(
			content: [
				EntityTitle(
					course.type.name,
					pageBuilder: (_) => CourseTypePage(course.type)
				),
				ListTile(
					title: Text(course.date.dateString(monthAsName: true)),
					leading: const Icon(AppIcon.date)
				),
				ListTile(
					title: Text(course.location.name),
					leading: const Icon(AppIcon.location)
				),
				if (course.instructors.isNotEmpty) ListTile(
					title: RichText(text: TextSpan(
						style: Theme.of(context).textTheme.titleMedium,
						children: [
							_instructorLink(context, course.instructors.first),
							for (final instructor in course.instructors.skip(1)) ...[
								const TextSpan(text: ', '),
								_instructorLink(context, instructor)
							]
						]
					)),
					leading: const Icon(AppIcon.instructors)
				),
				if (course.note != null) ListTile(
					title: Text(course.note!),
					leading: const Icon(AppIcon.note)
				)
			],
			actions: [
				IconButton(
					icon: const Icon(AppIcon.change),
					tooltip: "Змінити",
					onPressed: () => openPage(context, (_) => CourseForm(course))
				),
				IconButton(
					icon: const Icon(AppIcon.deleteEvent),
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	TextSpan _instructorLink(BuildContext context, Instructor instructor) => TextSpan(
		text: instructor.codeName,
		recognizer: TapGestureRecognizer()..onTap = () =>
			openPage(context, (_) => InstructorPage(instructor))
	);

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).delete(course);
		Navigator.pop(context);
	}
}
