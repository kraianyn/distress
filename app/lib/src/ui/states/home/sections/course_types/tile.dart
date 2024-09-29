import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import 'page.dart';
import '../../widgets/entity_tile.dart';


class CourseTypeTile extends StatelessWidget {
	const CourseTypeTile(this.type, {this.courseCount});

	final CourseType type;
	final int? courseCount;

	@override
	Widget build(BuildContext context) {
		final showCourseCount = courseCount != null && courseCount != 0;

		return EntityTile(
			title: type.name,
			trailing: showCourseCount ? courseCount.toString() : null,
			pageBuilder: (_) => CourseTypePage(type)
		);
	}
}
