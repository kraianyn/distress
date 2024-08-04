extension Date on DateTime {
	String get dateString => "${day.twoDigitString}.${month.twoDigitString}";
}

extension on int {
	String get twoDigitString => toString().padLeft(2, '0');
}
