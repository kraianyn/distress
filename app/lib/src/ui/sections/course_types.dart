import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course_type.dart';

import '../providers/course_types.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';


class CourseTypesSection extends ConsumerWidget {
	const CourseTypesSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final types = ref.watch(courseTypesNotifierProvider);

		return types.when(
			data: (courses) => _listWidget(courses),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}

	Widget _listWidget(List<CourseType> types) => ListView(
		children: types.map((type) => ListTile(
			title: Text(type.name),
		)).toList()
	);
}
