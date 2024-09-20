import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/date_time.dart';
import 'package:distress/src/ui/core/open_page.dart';

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
		final instructors = useRef(course?.instructors.toList() ?? <Instructor>[]);

		// ensured not to be null in ScheduleSection
		final types = ref.watch(courseTypesNotifierProvider).value!;
		final locations = ref.watch(locationsNotifierProvider).value!;
		final instructorsOptions = ref.watch(instructorsNotifierProvider).value!;

		return Scaffold(
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						controller: typeField,
						decoration: const InputDecoration(hintText: "Курс"),
						readOnly: true,
						onTap: () => openPage(context, (_) => OptionsPage(
							options: types,
							selected: type,
							field: typeField
						))
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
						onTap: () => openPage(context, (_) => OptionsPage(
							options: locations,
							selected: location,
							field: locationField
						))
					),
					TextField(
						controller: instructorsField,
						decoration: const InputDecoration(
							icon: Icon(AppIcon.instructors),
							hintText: "Інструктори"
						),
						readOnly: true,
						onTap: () => openPage(context, (_) => InstructorsOptionsPage(
							options: instructorsOptions,
							selected: instructors,
							field: instructorsField)
						)
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
						instructors.value,
						noteField
					)
					: () => _update(
						context,
						ref,
						type.value!,
						date.value!,
						location.value!,
						instructors.value,
						noteField
					)
			)
		);
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

	void _add(
		BuildContext context,
		WidgetRef ref,
		CourseType? type,
		DateTime? date,
		Location? location,
		List<Instructor> instructors,
		TextEditingController noteField
	) {
		if (type == null || date == null || location == null || instructors.isEmpty) return;

		final course = Course.added(
			type: type,
			date: date,
			location: location,
			instructors: instructors,
			note: _note(noteField)
		);
		ref.read(coursesNotifierProvider.notifier).add(course);
		Navigator.pop(context);
	}

	void _update(
		BuildContext context,
		WidgetRef ref,
		CourseType type,
		DateTime date,
		Location location,
		List<Instructor> instructors,
		TextEditingController noteField
	) {
		final note = _note(noteField);
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
		Navigator.pop(context);
	}

	String? _note(TextEditingController field) {
		final string = field.text.trim();
		return string.isNotEmpty ? string : null;
	}
}


class OptionsPage<O> extends StatelessWidget {
	const OptionsPage({
		required this.options,
		required this.selected,
		required this.field
	});

	final Iterable<O> options;
	final ObjectRef<O?> selected;
	final TextEditingController field;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(child: ListView(
				shrinkWrap: true,
				children: options.map((option) => OptionTile(
					option: option,
					selected: selected,
					field: field
				)).toList()
			))
		);
	}
}

class OptionTile<O> extends HookWidget {
	const OptionTile({
		required this.option,
		required this.selected,
		required this.field
	});

	final O option;
	final ObjectRef<O?> selected;
	final TextEditingController field;

	@override
	Widget build(BuildContext context) {
		final isSelected = useState(selected.value == option);

		return ListTile(
			title: Text(option.toString()),
			selected: isSelected.value,
			onTap: () {
				selected.value = option;
				isSelected.value = !isSelected.value;
				field.text = option.toString();
				Navigator.pop(context);
			}
		);
	}
}


class InstructorsOptionsPage extends StatelessWidget {
	const InstructorsOptionsPage({
		required this.options,
		required this.selected,
		required this.field
	});

	final Iterable<Instructor> options;
	final ObjectRef<List<Instructor>> selected;
	final TextEditingController field;

	@override
	Widget build(BuildContext context) {
		return PopScope(
			onPopInvokedWithResult: (_, __) => _updateField(),
			child: Scaffold(
				body: Center(child: ListView(
					shrinkWrap: true,
					children: options.map((instructor) => InstructorOptionTile(
						instructor: instructor,
						selectedInstructors: selected
					)).toList()
				)),
				floatingActionButton: FloatingActionButton(
					child: const Icon(AppIcon.confirm),
					onPressed: () => _confirm(context)
				)
			)
		);
	}

	void _updateField() {
		field.text = (selected.value..sort()).join(', ');
	}

	void _confirm(BuildContext context) {
		_updateField();
		Navigator.pop(context);
	}
}

class InstructorOptionTile extends HookWidget {
	const InstructorOptionTile({
		required this.instructor,
		required this.selectedInstructors
	});

	final Instructor instructor;
	final ObjectRef<List<Instructor>> selectedInstructors;

	@override
	Widget build(BuildContext context) {
		final isSelected = useState(selectedInstructors.value.contains(instructor));

		return ListTile(
			title: Text(instructor.codeName),
			selected: isSelected.value,
			onTap: () {
				if (!isSelected.value) {
					selectedInstructors.value.add(instructor);
				}
				else {
					selectedInstructors.value.remove(instructor);
				}
				isSelected.value = !isSelected.value;
			}
		);
	}
}
