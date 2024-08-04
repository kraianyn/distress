import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/data/firebase_options.dart';
import 'src/ui/app.dart';


Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();

	await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

	runApp(const App());
}
