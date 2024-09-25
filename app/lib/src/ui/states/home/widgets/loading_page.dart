import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';


class LoadingPage extends StatelessWidget {
	const LoadingPage();

	@override
	Widget build(BuildContext context) {
		return const Center(child: AppIcon.loading);
	}
}
