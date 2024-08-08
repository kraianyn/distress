import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course_type.dart';

import '../../providers/course_types.dart';
import '../../providers/courses.dart';


class CourseTypePage extends ConsumerWidget {
	const CourseTypePage(this.type);

	final CourseType type;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(body: Stack(
			children: [
				Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(type.name)
					]
				),
				SafeArea(
					child: Row(
						mainAxisAlignment: MainAxisAlignment.end,
						children: [
							IconButton(
								icon: const Icon(Icons.edit),
								tooltip: "Змінити",
								onPressed: () {}
							),
							IconButton(
								icon: const Icon(Icons.event_busy),
								tooltip: "Видалити",
								onPressed: () => _delete(context, ref, type)
							)
						]
					)
				)
			]	
		));
	}

	void _delete(BuildContext context, WidgetRef ref, CourseType type) {
		ref.read(coursesNotifierProvider.notifier).deleteWithType(type);
		ref.read(courseTypesNotifierProvider.notifier).delete(type);
		Navigator.of(context).pop();
	}
}
