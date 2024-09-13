import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/courses.dart';
import '../providers/course_types.dart';
import '../providers/instructors.dart';
import '../providers/locations.dart';

import '../widgets/tiles/course.dart';
import 'entities_section.dart';
import 'forms/course.dart';


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
			tileBuilder: CourseTile.new,
			formBuilder: canAdd ? (_) => const CourseForm() : null,
		);
	}
}
