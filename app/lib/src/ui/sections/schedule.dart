import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../date_time.dart';
import '../providers/courses.dart';
import '../widgets/entity_tile.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';

import 'pages/course.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider);

		return courses.when(
			data: (courses) => ListView(
				children: courses.map((course) => EntityTile(
					title: course.type.name,
					trailing: course.date.dateString,
					pageBuilder: (context) => CoursePage(course),
				)).toList()
			),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}
}
