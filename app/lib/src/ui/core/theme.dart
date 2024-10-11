import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const primaryColor = HSLColor.fromAHSL(1, 70, .3, .3);
final seed = ThemeData(
	colorScheme: ColorScheme.fromSeed(
		seedColor: primaryColor.toColor(),
		primary: primaryColor.toColor(),
		primaryContainer: primaryColor.withLightness(.55).toColor(),
		surface: primaryColor.withSaturation(.7).withLightness(.9).toColor()
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


const iconColor = Colors.black;

final accessCodeTextStyle = GoogleFonts.oxanium(
	fontSize: 24,
	fontWeight: FontWeight.w700,
	letterSpacing: 10
);
const hintTextColor = Color.fromRGBO(0, 0, 0, .6);
final headlineHintTextStyle = seed.textTheme.headlineMedium!.copyWith(
	color: hintTextColor
);

const spaceUnit = 8.0;

const paddingSize = spaceUnit * 2;
const paddingAround = EdgeInsets.all(paddingSize);
const horizontalPadding = EdgeInsets.symmetric(horizontal: paddingSize);

const verticalSpaceLarge = SizedBox(height: spaceUnit * 6);
const verticalSpaceMedium = SizedBox(height: spaceUnit * 2);
const verticalSpaceSmall = SizedBox(height: spaceUnit);


final theme = seed.copyWith(
	navigationBarTheme: NavigationBarThemeData(
		height: spaceUnit * 8,
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
		padding: const WidgetStatePropertyAll(paddingAround),
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
	padding: const WidgetStatePropertyAll(EdgeInsets.all(spaceUnit)),
	textStyle: WidgetStatePropertyAll(seed.textTheme.bodySmall)
);
