import 'package:flutter/material.dart';

import '../app_icon.dart';


class LoadingWidget extends StatelessWidget {
	const LoadingWidget();

	@override
	Widget build(BuildContext context) {
		return const Center(child: AppIcon.loading);
	}
}
