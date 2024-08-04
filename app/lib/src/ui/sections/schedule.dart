import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:distress/src/data/repository.dart';


class ScheduleSection extends HookWidget {
	const ScheduleSection();

	@override
	Widget build(BuildContext context) {
		final snapshot = useFuture(useMemoized(() => Repository().courses()));

		if (snapshot.connectionState == ConnectionState.waiting) {
			return const Center(child: Icon(Icons.cloudy_snowing));
		}

		return ListView(
			children: snapshot.data!.map((course) => ListTile(
				title: Text(course.type.name)
			)).toList(),
		);
	}
}
