import 'package:flutter/material.dart';


extension NavigationContext on BuildContext {
	Future<T?> openPage<T>(Widget Function(BuildContext) builder) =>
		Navigator.of(this).push(MaterialPageRoute<T>(builder: builder));
}
