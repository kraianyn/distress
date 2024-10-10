import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const seedColor = HSLColor.fromAHSL(1, 70, 1, .5);
const spacingUnit = 8.0;

final seed = ThemeData(
	colorScheme: ColorScheme.fromSeed(
		seedColor: seedColor.toColor(),
		surface: seedColor.withLightness(.9).toColor(),
		primaryContainer: seedColor.withSaturation(.38).withLightness(.6).toColor()
	),
	textTheme: GoogleFonts.ubuntuTextTheme(const TextTheme(
		headlineLarge: TextStyle(fontSize: 28, height: 1, fontWeight: FontWeight.bold),
		headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
		headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
		titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
		bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
		bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
	))
);


const paddingSize = spacingUnit * 2;

const iconColor = Colors.black;
const hintTextColor = Color.fromRGBO(0, 0, 0, .6);

final headlineTextStyle = seed.textTheme.headlineMedium!;
final accessCodeTextStyle = GoogleFonts.oxanium(
	fontSize: 24,
	fontWeight: FontWeight.w700,
	letterSpacing: 10
);
final headlineHintTextStyle = headlineTextStyle.copyWith(
	color: hintTextColor
);

const padding = EdgeInsets.all(paddingSize);
const horizontalPadding = EdgeInsets.symmetric(horizontal: paddingSize);
const verticalSpaceSmall = SizedBox(height: spacingUnit);
const verticalSpaceMedium = SizedBox(height: spacingUnit * 2);

final theme = seed.copyWith(
	navigationBarTheme: NavigationBarThemeData(
		height: spacingUnit * 8,
		backgroundColor: seed.colorScheme.primaryContainer,
		labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
		iconTheme: const WidgetStatePropertyAll(IconThemeData(
			color: iconColor
		))
	),
	bottomSheetTheme: BottomSheetThemeData(backgroundColor: seed.colorScheme.surface),
	listTileTheme: ListTileThemeData(
		titleTextStyle: seed.textTheme.titleMedium,
		subtitleTextStyle: seed.textTheme.bodySmall,
		leadingAndTrailingTextStyle: seed.textTheme.titleMedium,
		iconColor: iconColor,
		selectedTileColor: seed.colorScheme.primaryContainer,
		selectedColor: seed.colorScheme.onPrimaryContainer,
		contentPadding: const EdgeInsets.symmetric(horizontal: paddingSize)
	),
	filledButtonTheme: FilledButtonThemeData(style: ButtonStyle(
		padding: const WidgetStatePropertyAll(padding),
		textStyle: WidgetStatePropertyAll(seed.textTheme.bodyMedium)
	)),
	inputDecorationTheme: InputDecorationTheme(
		hintStyle: seed.textTheme.titleMedium!.copyWith(color: hintTextColor),
		iconColor: iconColor,
		border: InputBorder.none
	),
	iconTheme: const IconThemeData(color: iconColor),
	iconButtonTheme: const IconButtonThemeData(style: ButtonStyle(
		padding: WidgetStatePropertyAll(EdgeInsets.only(right: paddingSize))
	))
);

final smallButtonStyle = ButtonStyle(
	padding: const WidgetStatePropertyAll(EdgeInsets.all(spacingUnit)),
	textStyle: WidgetStatePropertyAll(seed.textTheme.bodySmall)
);
