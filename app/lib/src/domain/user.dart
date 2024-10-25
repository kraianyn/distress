class User {
	const User({
		required this.id,
		this.codeName,
		this.roles
	});

	final String id;
	final String? codeName;
	final List<Role>? roles;

	bool get isInstructor => roles!.contains(Role.teaching);
	bool get canManageSchedule => roles!.contains(Role.managingSchedule);
	bool get canManageUsers => roles!.contains(Role.managingUsers);
}

enum Role {
	teaching,
	managingSchedule,
	managingUsers
}
