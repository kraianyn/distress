import 'package:flutter/material.dart';
import 'package:distress/src/domain/course_type.dart';


class CourseTypePage extends StatelessWidget {
	const CourseTypePage(this.type);

	final CourseType type;

	@override
	Widget build(BuildContext context) {
		return Scaffold(body: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(type.name)
			]
		));
	}
}
