extension Date on DateTime {
	String dateString({monthName = false}) {
		if (!monthName) {
			return "${day.twoDigitString}.${month.twoDigitString}";
		}

		final monthString = switch (month) {
			DateTime.january => "січня",
			DateTime.february => "лютого",
			DateTime.march => "березня",
			DateTime.april => "квітня",
			DateTime.may => "травня",
			DateTime.june => "червня",
			DateTime.july => "липня",
			DateTime.august => "серпня",
			DateTime.september => "вересня",
			DateTime.october => "жовтня",
			DateTime.november => "листопада",
			_ => "грудня"
		};
		return "$day $monthString";
	}
}

extension on int {
	String get twoDigitString => toString().padLeft(2, '0');
}
