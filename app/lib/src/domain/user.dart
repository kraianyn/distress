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
	bool get canManageSchedule => actions!.contains(UserAction.managingSchedule);
	bool get canAddUsers => actions!.contains(UserAction.addingUsers);
}

enum UserAction {
	teaching,
	managingSchedule,
	addingUsers
}
