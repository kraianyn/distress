extension Quantity on int {
	String get courses => _objects('курс', 'курси', 'курсів');
	String get students => _objects('курсант', 'курсанти', 'курсантів');
	
	String _objects(String singular, String dual, String plural) {
		int remainder = this % 100;
		if (remainder >= 20) remainder %= 10;

        final word = switch (remainder) {
            1 => singular,
            >= 2 && <= 4 => dual,
            _ => plural
        };
        return "$this $word";
	}
}
