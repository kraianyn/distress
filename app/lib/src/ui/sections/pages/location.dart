import 'package:flutter/material.dart';
import 'package:distress/src/domain/location.dart';


class LocationPage extends StatelessWidget {
	const LocationPage(this.location);

	final Location location;

	@override
	Widget build(BuildContext context) {
		return Scaffold(body: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(location.name),
				Text(location.link)
			]
		));
	}
}
