import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/instructor.dart';

import '../../widgets/entity_tile.dart';
import 'page.dart';


class InstructorTile extends StatelessWidget {
	const InstructorTile(this.instructor, {this.courseCount});

	final Instructor instructor;
	final int? courseCount;

	@override
	Widget build(BuildContext context) {
		final showCourseCount = courseCount != null && courseCount != 0;

		return EntityTile(
			title: instructor.codeName,
			trailing: showCourseCount ? courseCount.toString() : null,
			pageBuilder: (_) => InstructorPage(instructor)
		);
	}
}
