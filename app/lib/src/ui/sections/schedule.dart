import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../date_time.dart';
import '../widgets/entity_tile.dart';

import '../providers/courses.dart';
import '../providers/course_types.dart';
import '../providers/instructors.dart';
import '../providers/locations.dart';

import 'entities_section.dart';
import 'forms/course.dart';
import 'pages/course.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider);
		final types = ref.watch(courseTypesNotifierProvider);
		final locations = ref.watch(locationsNotifierProvider);
		final instructors = ref.watch(instructorsNotifierProvider);
		final canAdd = types.hasValue && locations.hasValue && instructors.hasValue;

		return EntitiesSection(
			entities: courses,
			tileBuilder: (course) => EntityTile(
				title: course.type.name,
				trailing: course.date.dateString,
				pageBuilder: (context) => CoursePage(course)
			),
			formBuilder: canAdd ? (context) => const CourseForm() : null,
		);
	}
}
