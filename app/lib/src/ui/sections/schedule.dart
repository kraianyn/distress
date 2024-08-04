import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course.dart';
import '../providers/courses.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.watch(coursesNotifierProvider);

		return courses.when(
			data: (courses) => _listWidget(courses),
			loading: () => const Icon(Icons.cloudy_snowing),
			error: (error, stack) => const Icon(Icons.sentiment_dissatisfied)
		);
	}

	Widget _listWidget(List<Course> courses) => ListView(
		children: courses.map((course) => ListTile(
			title: Text(course.type.name),
			trailing: Text("${course.date.day}.${course.date.month}")
		)).toList()
	);
}
