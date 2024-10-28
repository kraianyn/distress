import 'package:flutter/material.dart';

extension ExtendedTextEditingController on TextEditingController {
	String get trimmedText => text.trim();

	int? get number => int.tryParse(text.trim());
}
