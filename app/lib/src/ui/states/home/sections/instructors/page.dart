import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/instructor.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../widgets/entity_page.dart';
import '../schedule/tile.dart';


class InstructorPage extends ConsumerWidget {
	const InstructorPage(this.instructor);

	final Instructor instructor;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.courses().value?.where(
			(course) => course.instructors.contains(instructor)
		);

		return EntityPage(
			content: [
				EntityTitle(instructor.codeName),
				if (courses != null) ...[
					const ListTile(),
					...courses.map(CourseTile.new)
				]
			],
			actions: [
				IconButton(
					icon: AppIcon.delete,
					tooltip: "Видалити",
					onPressed: () => _delete(context, ref)
				)
			]
		);
	}

	void _delete(BuildContext context, WidgetRef ref) {
		ref.instructorsNotifier.delete(instructor);
		Navigator.pop(context);
	}
}
