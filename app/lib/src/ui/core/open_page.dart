import 'package:flutter/material.dart';


Future<T?> openPage<T>(BuildContext context, Widget Function(BuildContext) pageBuilder) {
	return Navigator.of(context).push(MaterialPageRoute<T>(builder: pageBuilder));
}

