import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/instructor.dart';

import '../providers/instructors.dart';
import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';


class InstructorsSection extends ConsumerWidget {
	const InstructorsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final instructors = ref.watch(instructorsNotifierProvider);

		return instructors.when(
			data: (instructors) => _listWidget(instructors),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}

	Widget _listWidget(List<Instructor> instructors) => ListView(
		children: instructors.map((instructor) => ListTile(
			title: Text(instructor.codeName)
		)).toList(),
	);
}
