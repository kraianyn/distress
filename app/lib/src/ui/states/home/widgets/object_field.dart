import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/open_page.dart';
import 'package:distress/src/ui/core/theme.dart';


class ObjectField extends StatelessWidget {
	const ObjectField({
		required this.controller,
		required this.name,
		this.icon,
		this.isHeadline = false,
		required this.onTap
	});

	final TextEditingController controller;
	final String name;
	final IconData? icon;
	final bool isHeadline;
	final void Function() onTap;

	@override
	Widget build(BuildContext context) {
		final textTheme = Theme.of(context).textTheme;
		final textStyle = !isHeadline ? textTheme.titleMedium : textTheme.headlineMedium;

		return TextField(
			controller: controller,
			style: textStyle,
			decoration: InputDecoration(
				hintText: name,
				icon: icon != null ? Icon(icon) : null,
				hintStyle: !isHeadline ? null : headlineHintTextStyle
			),
			readOnly: true,
			onTap: onTap
		);
	}
}


class OptionsPage<O> extends StatelessWidget {
	const OptionsPage({
		required this.options,
		required this.selected,
		required this.field,
		this.formBuilder
	});

	final Iterable<O> options;
	final ObjectRef<O?> selected;
	final TextEditingController field;
	final Widget Function()? formBuilder;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(child: ListView(
				shrinkWrap: true,
				children: [
					...options.map((option) => OptionTile(
						option: option,
						selected: selected,
						field: field
					)),
					const ListTile()
				]
			)),
			floatingActionButton: formBuilder != null
				? FloatingActionButton(
					child: const Icon(AppIcon.add),
					onPressed: () => _addOption(context)
				)
				: null
		);
	}

	Future<void> _addOption(BuildContext context) async {
		final option = await openPage<O>(context, (_) => formBuilder!());
		if (option == null) return;

		selected.value = option;
		field.text = option.toString();
		Navigator.pop(context);
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
				Navigator.pop(context);
			}
		);
	}
}
