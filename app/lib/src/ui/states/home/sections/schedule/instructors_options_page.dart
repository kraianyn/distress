import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:distress/src/domain/entities/instructor.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';


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
						Text(
							"Інструктори",
							style: Theme.of(context).textTheme.headlineMedium
						).withHorizontalPadding,
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
