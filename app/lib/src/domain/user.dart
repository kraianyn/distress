class User {
	const User({
		required this.id,
		this.codeName,
		this.permissions
	});

	final String id;
	final String? codeName;
	final List<String>? permissions;
}

enum Permission {
	teaching,
	managingSchedule
}
