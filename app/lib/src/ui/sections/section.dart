import 'package:flutter/material.dart';

import 'course_types.dart';
import 'instructors.dart';
import 'locations.dart';
import 'schedule.dart';


enum Section {
	schedule(
		name: "Розклад",
		icon: Icons.calendar_month,
		widget: ScheduleSection()
	),
	courses(
		name: "Курси",
		icon: Icons.school,
		widget: CourseTypesSection()
	),
	instructors(
		name: "Інструктори",
		icon: Icons.group,
		widget: InstructorsSection()
	),
	locations(
		name: "Локації",
		icon: Icons.place,
		widget: LocationsSection()
	);

	const Section({
		required this.name,
		required this.icon,
		required this.widget
	});

	final String name;
	final IconData icon;
	final Widget widget;
}
