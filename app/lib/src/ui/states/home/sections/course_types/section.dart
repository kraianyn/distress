import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/providers/user.dart';

import '../../providers/course_types.dart';
import '../entities_section.dart';

import 'form.dart';
import 'tile.dart';


class CourseTypesSection extends ConsumerWidget {
	const CourseTypesSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final types = ref.watch(courseTypesNotifierProvider);
		final userCanAdd = ref.watch(userNotifierProvider)!.canManageSchedule;

		return EntitiesSection(
			entities: types,
			tileBuilder: CourseTypeTile.new,
			formBuilder: userCanAdd ? (_) => const CourseTypeForm() : null
		);
	}
}
