import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/course_types.dart';
import '../widgets/entity_tile.dart';

import 'entities_section.dart';
import 'forms/course_type.dart';
import 'pages/course_type.dart';


class CourseTypesSection extends ConsumerWidget {
	const CourseTypesSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final types = ref.watch(courseTypesNotifierProvider);

		return EntitiesSection(
			entities: types,
			tileBuilder: (type) => EntityTile(
				title: type.name,
				pageBuilder: (_) => CourseTypePage(type)
			),
			formBuilder: (_) => const CourseTypeForm()
		);
	}
}
