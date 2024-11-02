import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/extensions/date.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';
import 'package:distress/src/ui/core/extensions/text_editing_controller.dart';

import '../../widgets/entity_form.dart';
import '../../widgets/object_field.dart';
import '../course_types/form.dart';
import '../locations/form.dart';
import '../section.dart';

import 'instructors_options_page.dart';
import 'options_page.dart';


class CourseForm extends HookConsumerWidget {
	const CourseForm([this.course]);

	final Course? course;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final typeOptions = ref.courseTypes().value!;
		final locationOptions = ref.locations().value!;
		final instructorsOptions = ref.instructors().value!;

		final typeField = useTextEditingController(text: course?.type.name);
		final dateField = useTextEditingController(text: course?.date.dateString(monthName: true));
		final locationField = useTextEditingController(text: course?.location.toString());
		final instructorsField = useTextEditingController(text: course?.instructors.join(', '));
		final leadInstructorField = useTextEditingController(text: course?.leadInstructor?.codeName);
		final noteField = useTextEditingController(text: course?.note);

		final type = useRef(course?.type);
		final date = useRef(course?.date);
		final location = useRef(course?.location);
		final instructors = useRef(course?.instructors.toList() ?? <Instructor>[]);
		final leadInstructor = useRef(course?.leadInstructor);

		return EntityForm(
			adding: course == null,
			action: course == null
				? () => _add(
					context,
					ref,
					type.value,
					date.value,
					location.value,
					instructors.value,
					leadInstructor.value,
					noteField
				)
				: () => _update(
					context,
					ref,
					type.value!,
					date.value!,
					location.value!,
					instructors.value,
					leadInstructor.value,
					noteField
				),
			content: [
				ObjectField(
					controller: typeField,
					name: "Курс",
					isTitle: true,
					onTap: () => context.openPage((_) => OptionsPage(
						title: Section.courseTypes.name,
						options: typeOptions,
						selected: type,
						field: typeField,
						optionFormBuilder: CourseTypeForm.new,
						addOptionButtonLabel: "Додати курс"
					))
				),
				ObjectField(
					controller: dateField,
					name: "Дата",
					icon: AppIcon.date,
					onTap: () => _askDate(context, date, dateField)
				),
				ObjectField(
					controller: locationField,
					name: "Локація",
					icon: AppIcon.location,
					onTap: () => context.openPage((_) => OptionsPage(
						title: Section.locations.name,
						options: locationOptions,
						selected: location,
						field: locationField,
						optionFormBuilder: LocationForm.new,
						addOptionButtonLabel: "Додати локацію"
					))
				),
				ObjectField(
					controller: instructorsField,
					name: "Інструктори",
					icon: AppIcon.instructor,
					onTap: () => _askInstructors(
						context,
						instructorsOptions,
						instructors,
						instructorsField,
						leadInstructor,
						leadInstructorField
					)
				),
				ObjectField(
					controller: leadInstructorField,
					name: "Старший інструктор",
					icon: AppIcon.leadInstructor,
					onTap: () => _askLeadInstructor(
						context,
						leadInstructor,
						leadInstructorField,
						instructors.value
					)
				),
				TextField(
					controller: noteField,
					maxLines: null,
					style: Theme.of(context).textTheme.titleMedium,
					decoration: const InputDecoration(
						hintText: "Нотатка",
						icon: AppIcon.note
					)
				)
			].map((w) => w.withHorizontalPadding)
		);
	}

	Future<void> _askDate(
		BuildContext context,
		ObjectRef<DateTime?> date,
		TextEditingController field
	) async {
		final today = DateTime.now();
		final picked = await showDatePicker(
			context: context,
			initialDate: date.value,
			firstDate: date.value ?? today,
			lastDate: today.add(const Duration(days: 365))
		);
		if (picked != null) {
			date.value = picked;
			field.text = picked.dateString(monthName: true);
		}
	}

	Future<void> _askInstructors(
		BuildContext context,
		Iterable<Instructor> options,
		ObjectRef<List<Instructor>> selected,
		TextEditingController instructorsField,
		ObjectRef<Instructor?> leadInstructor,
		TextEditingController leadInstructorField
	) async {
		await context.openPage((_) => InstructorsOptionsPage(
			options: options,
			selected: selected,
			field: instructorsField
		));
		if (leadInstructor.value != null && !selected.value.contains(leadInstructor.value)) {
			leadInstructor.value = null;
			leadInstructorField.clear();
		}
	}

	void _askLeadInstructor(
		BuildContext context,
		ObjectRef<Instructor?> selected,
		TextEditingController field,
		List<Instructor> instructors
	) {
		if (instructors.isNotEmpty) {
			context.openPage((_) => OptionsPage(
				title: "Інструктори курсу",
				options: instructors,
				selected: selected,
				field: field
			));
		}
	}

	void _add(
		BuildContext context,
		WidgetRef ref,
		CourseType? type,
		DateTime? date,
		Location? location,
		List<Instructor> instructors,
		Instructor? leadInstructor,
		TextEditingController noteField
	) {
		if (
			type == null
			|| date == null
			|| location == null
			|| instructors.isEmpty
			|| leadInstructor == null
		) return;

		ref.coursesNotifier.add(Course.added(
			type: type,
			date: date,
			location: location,
			instructors: instructors,
			leadInstructor: leadInstructor,
			note: _note(noteField)
		));
		context.closePage();
	}

	void _update(
		BuildContext context,
		WidgetRef ref,
		CourseType type,
		DateTime date,
		Location location,
		List<Instructor> instructors,
		Instructor? leadInstructor,
		TextEditingController noteField
	) {
		if (leadInstructor == null) return;

		final note = _note(noteField);
		if (
			type != course!.type
			|| date != course!.date
			|| location != course!.location
			|| ! const ListEquality().equals(instructors, course!.instructors)
			|| leadInstructor != course!.leadInstructor
			|| note != course!.note
		) {
			ref.coursesNotifier.updateCourse(course!.copyWith(
				type: type,
				date: date,
				location: location,
				instructors: instructors,
				leadInstructor: leadInstructor,
				note: note
			));
		}

		context.closePage();
	}

	String? _note(TextEditingController field) {
		final string = field.trimmedText;
		return string.isNotEmpty ? string : null;
	}
}
