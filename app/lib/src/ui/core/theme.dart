import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const seedColor = HSLColor.fromAHSL(1, 65, .5, .5);
const spacingUnit = 8;

final seed = ThemeData(
	colorScheme: ColorScheme.fromSeed(
		seedColor: seedColor.toColor(),
		surfaceContainer: seedColor.withSaturation(.3).withLightness(.6).toColor()
	),
	textTheme: GoogleFonts.ubuntuTextTheme(const TextTheme(
		titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
		headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)
	))
);


const paddingSize = spacingUnit * 2.0;

const iconColor = Colors.black;
const hintTextColor = Color.fromRGBO(0, 0, 0, .6);

final headlineTextStyle = seed.textTheme.headlineMedium!;
final codeTextStyle = GoogleFonts.oxanium(
	fontSize: 24,
	fontWeight: FontWeight.w700,
	letterSpacing: 10
);
final headlineHintTextStyle = headlineTextStyle.copyWith(
	color: hintTextColor
);

final theme = seed.copyWith(
	scaffoldBackgroundColor: seedColor.withLightness(.8).toColor(),
	appBarTheme: AppBarTheme(
		backgroundColor: seed.colorScheme.surfaceContainer,
		titleTextStyle: seed.textTheme.headlineMedium
	),
	navigationBarTheme: const NavigationBarThemeData(
		height: spacingUnit * 8,
		labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
		iconTheme: WidgetStatePropertyAll(IconThemeData(
			color: iconColor
		))
	),
	listTileTheme: ListTileThemeData(
		titleTextStyle: seed.textTheme.titleMedium,
		leadingAndTrailingTextStyle: seed.textTheme.titleMedium,
		iconColor: iconColor,
		selectedTileColor: seed.colorScheme.surfaceContainer,
		selectedColor: seed.colorScheme.onSurface,
		contentPadding: const EdgeInsets.symmetric(horizontal: spacingUnit * 2)
	),
	inputDecorationTheme: InputDecorationTheme(
		hintStyle: seed.textTheme.titleMedium!.copyWith(color: hintTextColor),
		iconColor: iconColor,
		border: InputBorder.none
	),
	iconTheme: const IconThemeData(color: iconColor),
	iconButtonTheme: const IconButtonThemeData(style: ButtonStyle(
		padding: WidgetStatePropertyAll(EdgeInsets.only(right: spacingUnit * 2))
	))
);
