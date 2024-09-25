import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/providers/user.dart';

import '../../providers/courses.dart';
import '../../providers/course_types.dart';
import '../../providers/instructors.dart';
import '../../providers/locations.dart';

import '../entities_section.dart';

import 'form.dart';
import 'tile.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider);
		final types = ref.watch(courseTypesNotifierProvider);
		final locations = ref.watch(locationsNotifierProvider);
		final instructors = ref.watch(instructorsNotifierProvider);

		final userCanAdd = ref.watch(userNotifierProvider)!.canManageSchedule;
		final componentsFetched = types.hasValue && locations.hasValue && instructors.hasValue;
		final showButton = userCanAdd && componentsFetched;

		return EntitiesSection(
			entities: courses,
			tileBuilder: CourseTile.new,
			formBuilder: showButton ? CourseForm.new : null,
		);
	}
}
