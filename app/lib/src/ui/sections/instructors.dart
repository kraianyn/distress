import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/instructors.dart';
import '../widgets/entity_tile.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';

import 'pages/instructor.dart';


class InstructorsSection extends ConsumerWidget {
	const InstructorsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final instructors = ref.watch(instructorsNotifierProvider);

		return instructors.when(
			data: (instructors) => ListView(
				children: instructors.map((instructor) => EntityTile(
					title: instructor.codeName,
					pageBuilder: (context) => InstructorPage(instructor),
				)).toList(),
			),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}
}
