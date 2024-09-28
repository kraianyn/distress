import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../entities_section.dart';

import 'form.dart';
import 'tile.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.courses();
		final types = ref.courseTypes();
		final locations = ref.locations();
		final instructors = ref.instructors();

		final userCanAdd = ref.user()!.canManageSchedule;
		final componentsFetched = types.hasValue && locations.hasValue && instructors.hasValue;
		final showButton = userCanAdd && componentsFetched;

		return EntitiesSection(
			entities: courses,
			tileBuilder: CourseTile.new,
			formBuilder: showButton ? CourseForm.new : null,
		);
	}
}
