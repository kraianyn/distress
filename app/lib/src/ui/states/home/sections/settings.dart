import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/open_page.dart';
import 'package:distress/src/ui/core/providers/users_repository.dart';

import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';


class SettingsSection extends StatelessWidget {
	const SettingsSection();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(child: FilledButton(
				child: const Icon(Icons.person_add),
				onPressed: () => openPage(context, (_) => const NewUserPage())
			))
		);
	}
}

class NewUserPage extends HookWidget {
	const NewUserPage();

	@override
	Widget build(BuildContext context) {
		final showForm = useState(true);
		final permissions = useState(<String>[]);

		return Scaffold(
			appBar: AppBar(
				title: const Text("Додання користувача"),
				automaticallyImplyLeading: false
			),
			body: showForm.value
				? Center(child: FilledButton(
					child: const Text("Створити код"),
					onPressed: () => showForm.value = false
				))
				: AccessCodeCreationWidget(permissions.value)
		);
	}
}

class AccessCodeCreationWidget extends HookConsumerWidget {
	const AccessCodeCreationWidget(this.permissions);

	final List<String> permissions;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final snapshot = useFuture(useMemoized(
			() => ref.read(usersRepositoryProvider).createAccessCode(permissions)
		));
		
		if (snapshot.connectionState == ConnectionState.waiting) {
			return const LoadingPage();
		}

		final textStyle = Theme.of(context).textTheme.headlineMedium!;
		if (snapshot.hasData) {
			final code = snapshot.data!;
			Clipboard.setData(ClipboardData(text: code));
			return Center(child: Text(
				code,
				style: textStyle.copyWith(letterSpacing: textStyle.fontSize! / 2),
			));
		}

		return ErrorPage(snapshot.error!);
	}
}
