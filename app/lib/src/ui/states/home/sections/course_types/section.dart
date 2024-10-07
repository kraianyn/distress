import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/states/home/providers/courses.dart';

import '../entities_section.dart';

import 'form.dart';
import 'tile.dart';


class CourseTypesSection extends ConsumerWidget {
	const CourseTypesSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final types = ref.courseTypes();
		final courses = ref.courses();
		final userCanAdd = ref.user()!.canManageSchedule;

		return EntitiesSection(
			entities: types,
			tileBuilder: (type) => CourseTypeTile(
				type,
				courseCount: courses.withType(type)?.length
			),
			formBuilder: userCanAdd ? CourseTypeForm.new : null
		);
	}
}
