import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/course_type.dart';
import 'package:distress/src/domain/instructor.dart';
import 'package:distress/src/domain/location.dart';

import '../../date_time.dart';
import '../../open_page.dart';

import '../../providers/courses.dart';
import '../../providers/course_types.dart';
import '../../providers/instructors.dart';
import '../../providers/locations.dart';
import '../section.dart';


class CourseForm extends HookConsumerWidget {
	const CourseForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final typeField = useTextEditingController();
		final dateField = useTextEditingController();
		final locationField = useTextEditingController();
		final instructorsField = useTextEditingController();
		final noteField = useTextEditingController();

		final type = useRef<CourseType?>(null);
		final date = useRef<DateTime?>(null);
		final location = useRef<Location?>(null);
		final selectedInstructors = useRef(<Instructor>[]);

		// ensured not to be null in ScheduleSection
		final types = ref.watch(courseTypesNotifierProvider).value!;
		final locations = ref.watch(locationsNotifierProvider).value!;
		final instructors = ref.watch(instructorsNotifierProvider).value!;

		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: typeField,
						decoration: const InputDecoration(hintText: "Курс"),
						readOnly: true,
						onTap: () => _askOption(context, types, type, typeField)
					),
					TextField(
						controller: dateField,
						decoration: InputDecoration(
							icon: Icon(Section.schedule.icon),
							hintText: "Дата"
						),
						readOnly: true,
						onTap: () => _askDate(context, date, dateField)
					),
					TextField(
						controller: locationField,
						decoration: InputDecoration(
							icon: Icon(Section.locations.icon),
							hintText: "Локація"
						),
						readOnly: true,
						onTap: () => _askOption(context, locations, location, locationField)
					),
					TextField(
						controller: instructorsField,
						decoration: InputDecoration(
							icon: Icon(Section.instructors.icon),
							hintText: "Інструктори"
						),
						readOnly: true,
						onTap: () => _askInstructors(context, instructors, selectedInstructors, instructorsField)
					),
					TextField(
						controller: noteField,
						decoration: const InputDecoration(
							icon: Icon(Icons.short_text),
							hintText: "Нотатка"
						)
					)
				]
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(Icons.done),
				onPressed: () => _add(
					context,
					ref,
					type.value,
					date.value,
					location.value,
					selectedInstructors.value,
					noteField.text
				)
			)
		);
	}

	Future<void> _askOption<O>(
		BuildContext context,
		List<O> options,
		ObjectRef<O?> object,
		TextEditingController field
	) async {
		await openPage(context, (context) {
			return Scaffold(
				body: Center(child: ListView(
					shrinkWrap: true,
					children: options.map((option) => HookBuilder(
						builder: (context) {
							final isSelected = useState(object.value == option);

							return ListTile(
								title: Text(option.toString()),
								selected: isSelected.value,
								onTap: () {
									object.value = option;
									isSelected.value = !isSelected.value;
									field.text = option.toString();
									Navigator.of(context).pop();
								}
							);
						}
					)).toList()
				))
			);
		});
	}

	Future<void> _askDate(
		BuildContext context,
		ObjectRef<DateTime?> object,
		TextEditingController field
	) async {
		final now = DateTime.now();
		object.value = await showDatePicker(
			context: context,
			initialDate: object.value,
			firstDate: now,
			lastDate: now.add(const Duration(days: 365))
		);
		field.text = object.value != null ? object.value!.dateString : '';
	}

	Future<void> _askInstructors(
		BuildContext context,
		List<Instructor> options,
		ObjectRef<List<Instructor>> object,
		TextEditingController field
	) async {
		await openPage(context, (context) {
			return Scaffold(
				body: Center(child: ListView(
					shrinkWrap: true,
					children: options.map((instructor) => HookBuilder(
						builder: (context) {
							final isSelected = useState(object.value.contains(instructor));

							return ListTile(
								title: Text(instructor.codeName),
								selected: isSelected.value,
								onTap: () {
									if (!isSelected.value) {
										object.value.add(instructor);
									}
									else {
										object.value.remove(instructor);
									}

									isSelected.value = !isSelected.value;
									field.text = object.value.join(', ');
								}
							);
						}
					)).toList()
				)),
				floatingActionButton: FloatingActionButton(
					child: const Icon(Icons.done),
					onPressed: () => Navigator.of(context).pop()
				)
			);
		});
	}

	void _add(
		BuildContext context,
		WidgetRef ref,
		CourseType? type,
		DateTime? date,
		Location? location,
		List<Instructor> instructors,
		String note
	) {
		if (type == null || date == null || location == null || instructors.isEmpty) return;

		final course = Course.created(
			type: type,
			date: date,
			location: location,
			instructors: instructors,
			note: note.isNotEmpty ? note : null
		);
		ref.read(coursesNotifierProvider.notifier).add(course);
		Navigator.of(context).pop();
	}
}
