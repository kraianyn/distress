import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/instructors.dart';
import '../widgets/entity_tile.dart';

import 'entities_section.dart';
import 'forms/instructor.dart';
import 'pages/instructor.dart';


class InstructorsSection extends ConsumerWidget {
	const InstructorsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final instructors = ref.watch(instructorsNotifierProvider);

		return EntitiesSection(
			entities: instructors,
			tileBuilder: (instructor) => EntityTile(
				title: instructor.codeName,
				pageBuilder: (context) => InstructorPage(instructor)
			),
			formBuilder: (context) => const InstructorForm()
		);
	}
}
