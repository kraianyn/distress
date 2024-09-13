import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class Authorization extends HookConsumerWidget {
	const Authorization();

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		return Scaffold(
			appBar: AppBar(title: const Text("Доступ")),
			body: const Text("Доступ")
		);
	}
}
