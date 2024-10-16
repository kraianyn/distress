import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/instructor.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/date.dart';
import 'package:distress/src/ui/core/extensions/navigation_context.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/extensions/quantity.dart';

import '../../providers/entities/course.dart';
import '../../widgets/delete_action_button.dart';
import '../../widgets/entity_page.dart';
import '../../widgets/modify_action_button.dart';

import '../course_types/page.dart';
import '../instructors/page.dart';
import '../locations/page.dart';

import 'date_page.dart';
import 'form.dart';


class CoursePage extends ConsumerWidget {
	const CoursePage(this.course);

	final Course course;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final course = ref.watch(courseNotifierProvider(this.course));

		return EntityPage(
			content: [
				EntityTitle(
					course.type.name,
					pageBuilder: (_) => CourseTypePage(course.type)
				),
				ListTile(
					title: Text(course.date.dateString(monthName: true)),
					leading: AppIcon.date,
					onTap: () => context.openPage((_) => DatePage(course.date))
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
					leading: AppIcon.instructor
				),
				if (course.leadInstructor != null) ListTile(
					title: Text(course.leadInstructor!.codeName),
					leading: AppIcon.leadInstructor,
					onTap: () => context.openPage(
						(_) => InstructorPage(course.leadInstructor!)
					)
				),
				if (course.note != null) ListTile(
					title: Text(course.note!),
					leading: AppIcon.note
				),
				if (course.studentCount != null) ListTile(
					title: Text(course.studentCount!.students),
					leading: AppIcon.students
				),
				if (course.studentCount == null ) ...[  // && courseIsToday && userIsLeadInstructor
					verticalSpaceLarge,
					Padding(
						padding: horizontalPadding,
						child: FilledButton.icon(
							icon: AppIcon.finishCourse,
							label: const Text("Закінчити курс"),
							onPressed: () => context.openPage((context) => SummaryPage(course))
						)
					)
				]
			],
			actions: [
				ModifyActionButton(formBuilder: (_) => CourseForm(course)),
				DeleteActionButton(
					question: "Видалити курс?",
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

class SummaryPage extends HookConsumerWidget {
	const SummaryPage(this.course);

	final Course course;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final studentCountField = useTextEditingController();

		return Scaffold(body: Padding(
			padding: paddingAround,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text("Закінчення курсу", style: Theme.of(context).textTheme.headlineMedium),
					verticalSpaceLarge,
					TextField(
						controller: studentCountField,
						style: Theme.of(context).textTheme.titleMedium,
						decoration: const InputDecoration(
							hintText: "Кількість курсантів",
							icon: AppIcon.students
						)
					),
					verticalSpaceLarge,
					FilledButton(
						child: const Text("Зберегти"),
						onPressed: () => _saveStudentCount(context, ref, studentCountField)
					)
				]
			)
		));
	}

	void _saveStudentCount(
		BuildContext context,
		WidgetRef ref,
		TextEditingController studentCountField
	) {
		final studentCount = int.tryParse(studentCountField.text.trim());
		if (studentCount == null) return;

		ref.coursesNotifier.updateCourse(course.copyWith(studentCount: studentCount));
		context.closePage();
	}
}

// class CertificatesPage extends HookConsumerWidget {
// 	const CertificatesPage(this.course);

// 	final Course course;

// 	@override
// 	Widget build(BuildContext context, WidgetRef ref) {
// 		return Column(children: [
// 			Text("Номер курсу: $courseNumber"),
// 			Text("Номери сертифікатів: $firstCertificateNumber - $lastCertificateNumber")
// 		]);
// 	}
// }
