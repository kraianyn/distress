import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course.dart';

import '../providers/courses.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider);

		return courses.when(
			data: (courses) => _listWidget(courses),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}

	Widget _listWidget(List<Course> courses) => ListView(
		children: courses.map((course) => ListTile(
			title: Text(course.type.name),
			trailing: Text("${course.date.day}.${course.date.month}")
		)).toList()
	);
}
