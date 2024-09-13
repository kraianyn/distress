import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/open_page.dart';

import '../widgets/error_page.dart';
import '../widgets/loading_page.dart';


class EntitiesSection<E> extends ConsumerWidget {
	const EntitiesSection({
		required this.entities,
		required this.tileBuilder,
		this.formBuilder
	});

	final AsyncValue<List<E>> entities;
	final Widget Function(E) tileBuilder;
	final Widget Function(BuildContext)? formBuilder;

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return entities.when(
			data: (entities) => Scaffold(
				body: ListView(
					children: entities.map(tileBuilder).toList()
				),
				floatingActionButton: formBuilder != null ? FloatingActionButton(
					child: const Icon(AppIcon.add),
					onPressed: () => openPage(context, formBuilder!)
				) : null
			),
			loading: () => const LoadingPage(),
			error: (error, _) => ErrorPage(error)
		);
	}
}
