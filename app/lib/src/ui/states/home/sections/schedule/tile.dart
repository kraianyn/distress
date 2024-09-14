import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/ui/core/date_time.dart';

import 'page.dart';
import '../../widgets/entity_tile.dart';


class CourseTile extends StatelessWidget {
	const CourseTile(this.course, {this.title});

	final Course course;
	final String? title;

	@override
	Widget build(BuildContext context) {
		return EntityTile(
			title: title ?? course.type.name,
			trailing: course.date.dateString(),
			pageBuilder: (_) => CoursePage(course)
		);
	}
}
