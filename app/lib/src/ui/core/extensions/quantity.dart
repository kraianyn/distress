extension Quantity on int {
	String get courses {
		String word;
		int remainder = this % 100;

		if (remainder case >=11 && <=14) {
			word = "курсів";
		}
		else {
			remainder %= 10;
			word = switch (remainder) {
				1 => "курс",
				>=2 && <= 4 => "курси",
				_ => "курсів"
			};
		}

		return "$this $word";
	}
}
