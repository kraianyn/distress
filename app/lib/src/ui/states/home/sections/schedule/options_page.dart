import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/theme.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/extensions/inset_widget.dart';


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
					Text(
						title,
						style: Theme.of(context).textTheme.headlineMedium
					).withHorizontalPadding,
					verticalSpaceLarge,
					...options.map((option) => OptionTile(
						option: option,
						selected: selected,
						field: field
					)),
					verticalSpaceLarge,
					if (optionFormBuilder != null) FilledButton.tonalIcon(
						icon: AppIcon.add,
						label: Text(addOptionButtonLabel!),
						onPressed: () => _addOption(context)
					).withHorizontalPadding
				]
			))
		);
	}

	Future<void> _addOption(BuildContext context) async {
		final option = await context.openPage<O>((_) => optionFormBuilder!());
		if (option == null) return;

		selected.value = option;
		field.text = option.toString();
		if (context.mounted) {
			context.closePage();
		}
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
