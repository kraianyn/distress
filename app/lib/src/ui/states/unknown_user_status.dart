import 'package:flutter/material.dart';

import 'home/widgets/loading_page.dart';


class DeterminingUserStatus extends StatelessWidget {
	const DeterminingUserStatus();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text("Визначення статусу")),
			body: const LoadingPage()
		);
	}
}
