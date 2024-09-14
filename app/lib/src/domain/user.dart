class User {
	const User({
		required this.id,
		this.codeName,
		required this.permissions
	});

	final String id;
	final String? codeName;
	final List<String> permissions;
}
