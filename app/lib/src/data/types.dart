abstract class Field {
	static const code = 'code';
	static const codeName = 'codeName';
	static const date = 'date';
	static const instructors = 'instructors';
	static const link = 'link';
	static const location = 'location';
	static const name = 'name';
	static const note = 'note';
	static const permissions = 'permissions';
	static const type = 'type';
}

typedef ObjectMap = Map<String, dynamic>;

typedef EntityEntry = MapEntry<String, ObjectMap>;
