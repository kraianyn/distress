import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/context.dart';
import 'package:distress/src/ui/core/extensions/date.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

import '../../widgets/entity_form.dart';
import '../../widgets/object_field.dart';

import '../course_types/form.dart';
import '../locations/form.dart';
import '../section.dart';


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
			]
		);
	}

	Future<void> _askDate(
		BuildContext context,
		ObjectRef<DateTime?> object,
		TextEditingController field
	) async {
		final today = DateTime.now();
		final date = await showDatePicker(
			context: context,
			initialDate: object.value,
			firstDate: today,
			lastDate: today.add(const Duration(days: 365))
		);
		if (date != null) {
			object.value = date;
			field.text = date.dateString(monthName: true);
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
		final string = field.text.trim();
		return string.isNotEmpty ? string : null;
	}
}


class OptionsPage<O> extends StatelessWidget {
	const OptionsPage({
		required this.title,
		required this.options,
		required this.selected,
		required this.field,
		this.optionFormBuilder,
		this.addOptionButtonLabel
	});

	final String title;
	final Iterable<O> options;
	final ObjectRef<O?> selected;
	final TextEditingController field;
	final Widget Function()? optionFormBuilder;
	final String? addOptionButtonLabel;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(child: ListView(
				shrinkWrap: true,
				children: [
					Padding(
						padding: horizontalPadding,
						child: Text(
							title,
							style: Theme.of(context).textTheme.headlineMedium
						)
					),
					verticalSpaceLarge,
					...options.map((option) => OptionTile(
						option: option,
						selected: selected,
						field: field
					)),
					verticalSpaceLarge,
					if (optionFormBuilder != null) Padding(
						padding: horizontalPadding,
						child: FilledButton.tonalIcon(
							icon: AppIcon.add,
							label: Text(addOptionButtonLabel!),
							onPressed: () => _addOption(context)
						)
					)
				]
			))
		);
	}

	Future<void> _addOption(BuildContext context) async {
		final option = await context.openPage<O>((_) => optionFormBuilder!());
		if (option == null) return;

		selected.value = option;
		field.text = option.toString();
		context.closePage();
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
				field.text = option.toString();
				context.closePage();
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
					children: [
						Padding(
							padding: horizontalPadding,
							child: Text(
								"Інструктори",
								style: Theme.of(context).textTheme.headlineMedium
							),
						),
						verticalSpaceLarge,
						...options.map((instructor) => InstructorOptionTile(
							instructor: instructor,
							selected: selected
						))
					]
				)),
				floatingActionButton: FloatingActionButton(
					child: AppIcon.confirm,
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
		context.closePage();
	}
}

class InstructorOptionTile extends HookWidget {
	const InstructorOptionTile({
		required this.instructor,
		required this.selected
	});

	final Instructor instructor;
	final ObjectRef<List<Instructor>> selected;

	@override
	Widget build(BuildContext context) {
		final isSelected = useState(selected.value.contains(instructor));

		return ListTile(
			title: Text(instructor.codeName),
			selected: isSelected.value,
			onTap: () {
				if (!isSelected.value) {
					selected.value.add(instructor);
				}
				else {
					selected.value.remove(instructor);
				}
				isSelected.value = !isSelected.value;
			}
		);
	}
}
