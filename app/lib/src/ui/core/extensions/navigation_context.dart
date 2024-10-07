import 'package:flutter/material.dart';


extension NavigationContext on BuildContext {
	Future<T?> openPage<T extends Object?>(Widget Function(BuildContext) builder) =>
		Navigator.of(this).push(MaterialPageRoute<T>(builder: builder));
	
	void closePage<T extends Object?>([T? data]) => Navigator.of(this).pop(data);
}
