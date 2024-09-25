import 'package:flutter/material.dart';

import 'package:distress/src/ui/core/app_icon.dart';


class LoadingWidget extends StatelessWidget {
	const LoadingWidget();

	@override
	Widget build(BuildContext context) {
		return const Center(child: AppIcon.loading);
	}
}
