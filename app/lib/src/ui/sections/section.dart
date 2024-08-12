import 'package:flutter/material.dart';

import '../app_icon.dart';

import 'course_types.dart';
import 'instructors.dart';
import 'locations.dart';
import 'schedule.dart';


enum Section {
	schedule(
		name: "Розклад",
		icon: AppIcon.schedule,
		widget: ScheduleSection()
	),
	courseTypes(
		name: "Курси",
		icon: AppIcon.courseType,
		widget: CourseTypesSection()
	),
	instructors(
		name: "Інструктори",
		icon: AppIcon.instructors,
		widget: InstructorsSection()
	),
	locations(
		name: "Локації",
		icon: AppIcon.location,
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
