import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/date.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';
import 'package:distress/src/ui/core/widgets/error.dart';
import 'package:distress/src/ui/core/widgets/loading.dart';

import '../../providers/course_archive_months.dart';
import '../entities_section.dart';
import '../section.dart';

import 'form.dart';
import 'tile.dart';


class ScheduleSection extends ConsumerWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final courses = ref.courses();
		final types = ref.courseTypes();
		final locations = ref.locations();
		final instructors = ref.instructors();

		final userCanAdd = ref.user()!.canManageSchedule;
		final componentsFetched = types.hasValue && locations.hasValue && instructors.hasValue;
		final showButton = userCanAdd && componentsFetched;

		return EntitiesSection(
			section: Section.schedule,
			entities: courses,
			tileBuilder: CourseTile.new,
			appBarAction: () => showModalBottomSheet(
				context: context,
				builder: (context) => const CourseArchiveMonthsSheet()
			),
			formBuilder: showButton ? CourseForm.new : null
		);
	}
}

class CourseArchiveMonthsSheet extends ConsumerWidget {
	const CourseArchiveMonthsSheet();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return ref.watch(courseArchiveMonthsProvider).when(
			data: (months) => GridView.count(
				crossAxisCount: 3,
				mainAxisSpacing: paddingSize,
				crossAxisSpacing: paddingSize,
				shrinkWrap: true,
				childAspectRatio: 1,
				children: months.map((month) => FilledButton(
					child: Text('${month.month.twoDigitString}.${month.year}'),
					onPressed: () {}
				)).toList()
			).withPaddingAround,
			loading: () => const LoadingWidget().withPaddingAround,
			error: ErrorWidget.new
		);
	}
}
