import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/course_types.dart';
import '../widgets/tiles/course_type.dart';

import 'entities_section.dart';
import 'forms/course_type.dart';


class CourseTypesSection extends ConsumerWidget {
	const CourseTypesSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final types = ref.watch(courseTypesNotifierProvider);

		return EntitiesSection(
			entities: types,
			tileBuilder: CourseTypeTile.new,
			formBuilder: (_) => const CourseTypeForm()
		);
	}
}
