import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/app_icon.dart';
import '../core/theme.dart';
import '../core/extensions/providers_references.dart';
import '../core/widgets/described_page.dart';


class Introduction extends HookConsumerWidget {
	const Introduction();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final codeNameField = useTextEditingController();

		return DescribedPage(
			title: "Знайомство",
			text: "Як інші знатимуть, що ти це ти?",
			content: [
				TextField(
					controller: codeNameField,
					style: Theme.of(context).textTheme.titleMedium,
					decoration: const InputDecoration(
						hintText: "Позивний",
						icon: AppIcon.account
					)
				),
				verticalSpaceLarge,
				FilledButton.icon(
					icon: AppIcon.home,
					label: const Text("Перейти в додаток"),
					onPressed: () => _addInfo(ref, codeNameField)
				)
			]
		);
	}

	Future<void> _addInfo(WidgetRef ref, TextEditingController codeNameField) async {
		final codeName = codeNameField.text.trim();
		if (codeName.isNotEmpty) {
			await ref.appStateNotifier.saveUserInfo(codeName);
		}
	}
}
