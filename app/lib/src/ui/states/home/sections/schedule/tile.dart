import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/course.dart';

import 'package:distress/src/ui/core/extensions/date.dart';

import '../../widgets/entity_tile.dart';
import 'page.dart';


class CourseTile extends StatelessWidget {
	const CourseTile(this.course, {this.showLocation = false});

	final Course course;
	final bool showLocation;

	@override
	Widget build(BuildContext context) {
		return EntityTile(
			title: !showLocation ? course.type.name : course.location.name,
			subtitle: !showLocation ? null : course.location.city,
			trailing: course.date.dateString(),
			pageBuilder: (_) => CoursePage(course)
		);
	}
}
