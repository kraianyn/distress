class User {
	const User({
		required this.id,
		this.codeName,
		this.actions
	});

	final String id;
	final String? codeName;
	final List<UserAction>? actions;

	bool get isInstructor => actions!.contains(UserAction.teaching);
}

enum UserAction {
	teaching,
	managingSchedule,
	addingUsers
}
