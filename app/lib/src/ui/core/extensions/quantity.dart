extension Quantity on int {
	String get courses {
		int remainder = this % 100;
		if (remainder >= 20) remainder %= 10;

        final word = switch (remainder) {
            1 => 'курс',
            >= 2 && <= 4 => 'курси',
            _ => 'курсів'
        };
        return "$this $word";
	}
}
