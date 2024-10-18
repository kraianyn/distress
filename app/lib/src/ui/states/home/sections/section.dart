import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';

import 'course_types/section.dart';
import 'instructors/section.dart';
import 'locations/section.dart';
import 'schedule/section.dart';
import 'account/section.dart';


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
		icon: AppIcon.instructor,
		widget: InstructorsSection()
	),
	locations(
		name: "Локації",
		icon: AppIcon.location,
		widget: LocationsSection()
	),
	account(
		name: "Акаунт",
		icon: AppIcon.account,
		widget: AccountSection()
	);

	const Section({
		required this.name,
		required this.icon,
		required this.widget
	});

	final String name;
	final Icon icon;
	final Widget widget;
}
