import 'package:flutter/material.dart';

import 'package:distress/src/domain/instructor.dart';

import 'entity.dart';


class InstructorPage extends StatelessWidget {
	const InstructorPage(this.instructor);

	final Instructor instructor;

	@override
	Widget build(BuildContext context) {
		return EntityPage(
			content: [
				Text(instructor.codeName)
			]
		);
	}
}
