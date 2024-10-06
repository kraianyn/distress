import 'package:flutter/material.dart';

import 'package:distress/src/domain/entities/location.dart';

import '../../widgets/entity_tile.dart';
import 'page.dart';


class LocationTile extends StatelessWidget {
	const LocationTile(this.location, {this.courseCount});

	final Location location;
	final int? courseCount;

	@override
	Widget build(BuildContext context) {
		final showCourseCount = courseCount != null && courseCount != 0;

		return EntityTile(
			title: location.name,
			subtitle: location.city,
			trailing: showCourseCount ? courseCount.toString() : null,
			pageBuilder: (_) => LocationPage(location)
		);
	}
}
