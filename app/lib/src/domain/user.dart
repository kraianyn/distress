class User {
	const User({
		required this.id,
		this.codeName,
		this.actions
	});

	final String id;
	final String? codeName;
	final List<UserAction>? actions;
}

enum UserAction {
	teaching,
	managingSchedule
}
