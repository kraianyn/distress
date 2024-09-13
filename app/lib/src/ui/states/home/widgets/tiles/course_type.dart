import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/course_type.dart';

import '../../sections/pages/course_type.dart';
import 'entity.dart';


class CourseTypeTile extends StatelessWidget {
	const CourseTypeTile(this.type);

	final CourseType type;

	@override
	Widget build(BuildContext context) {
		return EntityTile(
			title: type.name,
			pageBuilder: (_) => CourseTypePage(type)
		);
	}
}
