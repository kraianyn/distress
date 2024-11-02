import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../providers/courses.dart';
import '../entities_section.dart';
import '../section.dart';

import 'tile.dart';


class InstructorsSection extends ConsumerWidget {
	const InstructorsSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final instructors = ref.instructors();
		final courses = ref.courses();

		return EntitiesSection(
			section: Section.instructors,
			entities: instructors,
			tileBuilder: (instructor) => InstructorTile(
				instructor,
				courseCount: courses.withInstructor(instructor)?.length
			)
		);
	}
}
