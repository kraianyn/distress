import 'package:flutter/material.dart';

import '../theme.dart';


extension InsetWidget on Widget {
	Padding get withHorizontalPadding => Padding(
		padding: horizontalPadding,
		child: this
	);

	Padding get withPaddingAround => Padding(
		padding: paddingAround,
		child: this
	);
}
