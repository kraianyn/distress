import 'package:flutter/material.dart';

import 'package:distress/src/domain/course.dart';

import '../../date_time.dart';
import '../../sections/pages/course.dart';

import 'entity.dart';


class CourseTile extends StatelessWidget {
	const CourseTile(this.course, {this.title});

	final Course course;
	final String? title;

	@override
	Widget build(BuildContext context) {
		return EntityTile(
			title: title ?? course.type.name,
			trailing: course.date.dateString,
			pageBuilder: (_) => CoursePage(course)
		);
	}
}
