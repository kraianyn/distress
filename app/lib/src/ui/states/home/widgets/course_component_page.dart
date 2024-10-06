import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/course.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/quantity.dart';

import '../sections/schedule/tile.dart';
import 'entity_page.dart';


class CourseComponentPage extends StatelessWidget {
	const CourseComponentPage({
		required this.title,
		this.content = const [],
		required this.courses,
		this.showCourseLocation = false,
		this.actions = const []
	});

	final String title;
	final List<Widget> content;
	final List<Course>? courses;
	final bool showCourseLocation;
	final List<Widget> actions;

	@override
	Widget build(BuildContext context) {
		return EntityPage(
			content: [
				EntityTitle(title),
				...content,
				if (courses != null) ...[
					const ListTile(),
					ListTile(title: Text(
						courses!.length.courses,
						style: Theme.of(context).textTheme.headlineSmall
					), leading: AppIcon.schedule),
					...courses!.map((course) => CourseTile(
						course,
						showLocation: showCourseLocation
					))
				]
			],
			actions: actions
		);
	}
}
