import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/navigation_context.dart';

import '../widgets/error.dart';
import '../widgets/loading.dart';


class EntitiesSection<E> extends StatelessWidget {
	const EntitiesSection({
		required this.entities,
		required this.tileBuilder,
		this.formBuilder
	});

	final AsyncValue<List<E>> entities;
	final Widget Function(E) tileBuilder;
	final Widget Function()? formBuilder;

	@override
	Widget build(BuildContext context) {
		return entities.when(
			data: (entities) => Scaffold(
				body: ListView(
					children: entities.map(tileBuilder).toList()
				),
				floatingActionButton: formBuilder != null ? FloatingActionButton(
					child: AppIcon.add,
					onPressed: () => context.openPage((_) => formBuilder!())
				) : null
			),
			loading: () => const LoadingWidget(),
			error: ErrorWidget.new
		);
	}
}
