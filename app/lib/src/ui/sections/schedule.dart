import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../date_time.dart';
import '../providers/courses.dart';
import '../widgets/entity_tile.dart';

import 'entities_section.dart';
import 'pages/course.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider);

		return EntitiesSection(
			entities: courses,
			tileBuilder: (course) => EntityTile(
				title: course.type.name,
				trailing: course.date.dateString,
				pageBuilder: (context) => CoursePage(course)
			)
		);
	}
}
