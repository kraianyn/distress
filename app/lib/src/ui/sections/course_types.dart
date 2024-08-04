import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/course_types.dart';
import '../widgets/entity_tile.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';

import 'pages/course_type.dart';


class CourseTypesSection extends ConsumerWidget {
	const CourseTypesSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final types = ref.watch(courseTypesNotifierProvider);

		return types.when(
			data: (types) => ListView(
				children: types.map((type) => EntityTile(
					title: type.name,
					pageBuilder: (context) => CourseTypePage(type)
				)).toList()
			),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}
}
