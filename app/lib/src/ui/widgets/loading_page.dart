import 'package:flutter/material.dart';

import '../app_icon.dart';


class LoadingPage extends StatelessWidget {
	const LoadingPage();

	@override
	Widget build(BuildContext context) {
		return const Center(child: Icon(AppIcon.loading));
	}
}
