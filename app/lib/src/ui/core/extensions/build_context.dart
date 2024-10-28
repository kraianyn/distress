import 'package:flutter/material.dart';


extension ExtendedBuildContext on BuildContext {
	Future<T?> openPage<T extends Object?>(Widget Function(BuildContext) builder) =>
		Navigator.of(this).push(MaterialPageRoute<T>(builder: builder));
	
	void closePage<T extends Object?>([T? data]) => Navigator.of(this).pop(data);

	void showSnackBar(String text) =>
		ScaffoldMessenger.of(this).showSnackBar(SnackBar(
			content: Text(text),
			duration: const Duration(seconds: 2)
		));
}
