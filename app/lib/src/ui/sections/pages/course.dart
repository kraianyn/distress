import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/instructor.dart';

import '../../open_page.dart';
import '../../date_time.dart';
import '../../widgets/entity_title.dart';

import '../../providers/courses.dart';
import '../../providers/pages/course.dart';

import '../forms/course.dart';
import '../section.dart';

import 'course_type.dart';
import 'entity.dart';
import 'instructor.dart';


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
					title: Text(course.date.dateString),
					leading: const Icon(Icons.today)
				),
				ListTile(
					title: Text(course.location.name),
					leading: Icon(Section.locations.icon)
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
					leading: Icon(Section.instructors.icon)
				),
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

	TextSpan _instructorLink(BuildContext context, Instructor instructor) => TextSpan(
		text: instructor.codeName,
		recognizer: TapGestureRecognizer()
			..onTap = () => openPage(context, (_) => InstructorPage(instructor))
	);

	void _delete(BuildContext context, WidgetRef ref) {
		ref.read(coursesNotifierProvider.notifier).delete(course);
		Navigator.of(context).pop();
	}
}
