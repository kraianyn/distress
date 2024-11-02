import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/ui/core/app_icon.dart';
import 'package:distress/src/ui/core/extensions/build_context.dart';
import 'package:distress/src/ui/core/widgets/error.dart';
import 'package:distress/src/ui/core/widgets/loading.dart';

import '../widgets/app_bar.dart';
import 'section.dart';


class EntitiesSection<E> extends StatelessWidget {
	const EntitiesSection({
		required this.section,
		required this.entities,
		required this.tileBuilder,
		this.formBuilder
	});

	final Section section;
	final AsyncValue<List<E>> entities;
	final Widget Function(E) tileBuilder;
	final Widget Function()? formBuilder;

	@override
	Widget build(BuildContext context) {
		return entities.when(
			data: (entities) => Scaffold(
				appBar: HomeAppBar(
					context: context,
					section: section
				),
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
