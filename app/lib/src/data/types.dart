abstract class Field {
	static const roles = 'roles';
	static const city = 'city';
	static const code = 'code';
	static const codeName = 'codeName';
	static const courseCount = 'courseCount';
	static const date = 'date';
	static const instructors = 'instructors';
	static const leadInstructor = 'leadInstructor';
	static const link = 'link';
	static const location = 'location';
	static const name = 'name';
	static const note = 'note';
	static const studentCount = 'studentCount';
	static const type = 'type';
}

typedef ObjectMap = Map<String, dynamic>;

typedef EntityEntry = MapEntry<String, ObjectMap>;
