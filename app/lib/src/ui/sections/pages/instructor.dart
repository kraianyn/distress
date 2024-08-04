import 'package:flutter/material.dart';
import 'package:distress/src/domain/instructor.dart';


class InstructorPage extends StatelessWidget {
	const InstructorPage(this.instructor);

	final Instructor instructor;

	@override
	Widget build(BuildContext context) {
		return Scaffold(body: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(instructor.codeName)
			]
		));
	}
}
