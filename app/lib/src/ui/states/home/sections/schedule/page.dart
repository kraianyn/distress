import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/instructor.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/date.dart';
import 'package:distress/src/ui/core/extensions/navigation_context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../providers/pages/course.dart';
import '../../widgets/delete_action_button.dart';
import '../../widgets/entity_page.dart';
import '../../widgets/modify_action_button.dart';

import '../course_types/page.dart';
import '../instructors/page.dart';
import '../locations/page.dart';

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
					title: Text(course.date.dateString(monthName: true)),
					leading: AppIcon.date
				),
				ListTile(
					title: Text(course.location.name),
					subtitle: Text(course.location.city),
					leading: AppIcon.location,
					onTap: () => context.openPage((_) => LocationPage(course.location))
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
					leading: AppIcon.instructors
				),
				if (course.leadInstructor != null) ListTile(
					title: Text(course.leadInstructor!.codeName),
					leading: AppIcon.leadInstructor
				),
				if (course.note != null) ListTile(
					title: Text(course.note!),
					leading: AppIcon.note
				)
			],
			actions: [
				ModifyActionButton(formBuilder: (_) => CourseForm(course)),
				DeleteActionButton(
					title: "Видалити курс?",
					delete: () => ref.coursesNotifier.delete(course)
				)
			]
		);
	}

	TextSpan _instructorLink(BuildContext context, Instructor instructor) => TextSpan(
		text: instructor.codeName,
		recognizer: TapGestureRecognizer()..onTap = () =>
			context.openPage((_) => InstructorPage(instructor))
	);
}
