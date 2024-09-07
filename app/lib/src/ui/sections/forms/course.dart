import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/course_type.dart';
import 'package:distress/src/domain/instructor.dart';
import 'package:distress/src/domain/location.dart';

import '../../app_icon.dart';
import '../../date_time.dart';
import '../../open_page.dart';

import '../../providers/courses.dart';
import '../../providers/course_types.dart';
import '../../providers/instructors.dart';
import '../../providers/locations.dart';
import '../../providers/pages/course.dart';


class CourseForm extends HookConsumerWidget {
	const CourseForm([this.course]);

	final Course? course;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final typeField = useTextEditingController(text: course?.type.name);
		final dateField = useTextEditingController(text: course?.date.dateString(monthAsName: true));
		final locationField = useTextEditingController(text: course?.location.name);
		final instructorsField = useTextEditingController(text: course?.instructors.join(', '));
		final noteField = useTextEditingController(text: course?.note);

		final type = useRef<CourseType?>(course?.type);
		final date = useRef<DateTime?>(course?.date);
		final location = useRef<Location?>(course?.location);
		final selectedInstructors = useRef(course?.instructors.toList() ?? <Instructor>[]);

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
						decoration: const InputDecoration(
							icon: Icon(AppIcon.date),
							hintText: "Дата"
						),
						readOnly: true,
						onTap: () => _askDate(context, date, dateField)
					),
					TextField(
						controller: locationField,
						decoration: const InputDecoration(
							icon: Icon(AppIcon.location),
							hintText: "Локація"
						),
						readOnly: true,
						onTap: () => _askOption(context, locations, location, locationField)
					),
					TextField(
						controller: instructorsField,
						decoration: const InputDecoration(
							icon: Icon(AppIcon.instructors),
							hintText: "Інструктори"
						),
						readOnly: true,
						onTap: () => _askInstructors(context, instructors, selectedInstructors, instructorsField)
					),
					TextField(
						controller: noteField,
						decoration: const InputDecoration(
							icon: Icon(AppIcon.note),
							hintText: "Нотатка"
						)
					)
				]
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(AppIcon.confirm),
				onPressed: course == null
					? () => _add(
						context,
						ref,
						type.value,
						date.value,
						location.value,
						selectedInstructors.value,
						noteField.text
					)
					: () => _update(
						context,
						ref,
						type.value!,
						date.value!,
						location.value!,
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
		final today = DateTime.now();
		object.value = await showDatePicker(
			context: context,
			initialDate: object.value,
			firstDate: today,
			lastDate: today.add(const Duration(days: 365))
		);
		field.text = object.value != null ? object.value!.dateString(monthAsName: true) : '';
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
								}
							);
						}
					)).toList()
				)),
				floatingActionButton: FloatingActionButton(
					child: const Icon(AppIcon.confirm),
					onPressed: () {
						object.value.sort();
						field.text = object.value.join(', ');
						Navigator.of(context).pop();
					}
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
		String noteString
	) {
		if (type == null || date == null || location == null || instructors.isEmpty) return;

		final course = Course.created(
			type: type,
			date: date,
			location: location,
			instructors: instructors,
			note: _note(noteString)
		);
		ref.read(coursesNotifierProvider.notifier).add(course);
		Navigator.of(context).pop();
	}

	void _update(
		BuildContext context,
		WidgetRef ref,
		CourseType type,
		DateTime date,
		Location location,
		List<Instructor> instructors,
		String noteString
	) {
		final note = _note(noteString);
		if (
			type == course!.type
			&& date == course!.date
			&& location == course!.location
			&& const ListEquality().equals(instructors, course!.instructors)
			&& note == course!.note
		) return;

		final updatedCourse = course!.copyWith(
			type: type,
			date: date,
			location: location,
			instructors: instructors,
			note: note
		);
		ref.read(coursePageNotifierProvider(course!).notifier).update(updatedCourse);
		ref.read(coursesNotifierProvider.notifier).updateCourse(updatedCourse);
		Navigator.of(context).pop();
	}

	String? _note(String string) => string.isNotEmpty ? string : null;
}
