import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/extensions/date.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../providers/courses.dart';
import '../../widgets/course_component_page.dart';


class DatePage extends ConsumerWidget {
	const DatePage(this.date);

	final DateTime date;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.courses().withDate(date)?.toList();

		return CourseComponentPage(
			title: date.dateString(monthName: true),
			courses: courses
		);
	}
}
