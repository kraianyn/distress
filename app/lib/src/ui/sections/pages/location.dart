import 'package:flutter/material.dart';

import 'package:distress/src/domain/location.dart';

import 'entity.dart';


class LocationPage extends StatelessWidget {
	const LocationPage(this.location);

	final Location location;

	@override
	Widget build(BuildContext context) {
		return EntityPage(
			content: [
				Text(location.name),
				Text(location.link)
			]
		);
	}
}
