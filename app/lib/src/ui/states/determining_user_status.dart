import 'package:flutter/material.dart';

import '../core/widgets/loading.dart';


class DeterminingUserStatus extends StatelessWidget {
	const DeterminingUserStatus();

	@override
	Widget build(BuildContext context) {
		return Scaffold(body: const LoadingWidget());
	}
}
