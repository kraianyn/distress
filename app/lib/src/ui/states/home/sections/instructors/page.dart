import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/instructor.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/states/home/providers/courses.dart';

import '../../widgets/course_component_page.dart';


class InstructorPage extends ConsumerWidget {
	const InstructorPage(this.instructor);

	final Instructor instructor;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.courses().withInstructor(instructor)?.toList();

		return CourseComponentPage(
			title: instructor.codeName,
			courses: courses
		);
	}
}
