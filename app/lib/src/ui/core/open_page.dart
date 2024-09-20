import 'package:flutter/material.dart';


Future<T?> openPage<T>(
	BuildContext context,
	Widget Function(BuildContext) pageBuilder
) => Navigator.push(
	context,
	MaterialPageRoute<T>(builder: pageBuilder)
);

