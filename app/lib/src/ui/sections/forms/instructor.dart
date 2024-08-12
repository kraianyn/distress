import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/domain/instructor.dart';

import '../../app_icon.dart';
import '../../providers/instructors.dart';


class InstructorForm extends HookConsumerWidget {
	const InstructorForm();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeNameField = useTextEditingController();

		return Scaffold(
			body: Center(
				child: TextField(
					controller: codeNameField,
					decoration: const InputDecoration(hintText: "Позивний")
				)
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(AppIcon.confirm),
				onPressed: () => _add(context, ref, codeNameField.text)
			)
		);
	}

	void _add(BuildContext context, WidgetRef ref, String codeName) {
		final instructor = Instructor.created(codeName: codeName);
		ref.read(instructorsNotifierProvider.notifier).add(instructor);
		Navigator.of(context).pop();
	}
}
