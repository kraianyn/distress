import 'package:flutter/material.dart';
import 'package:distress/src/domain/course.dart';

import '../../date_time.dart';


class CoursePage extends StatelessWidget {
	const CoursePage(this.course);

	final Course course;

	@override
	Widget build(BuildContext context) {
		return Scaffold(body: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(course.type.name),
				Text(course.date.dateString),
				Text(course.location.name),
				Text(course.instructors.join(', '))
			]
		));
	}
}
