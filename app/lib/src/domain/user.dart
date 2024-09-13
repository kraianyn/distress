class User {
	const User({
		required this.id,
		required this.codeName,
		required this.permissions
	});

	final String id;
	final String codeName;
	final List<String> permissions;
}
