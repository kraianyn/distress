abstract class Entity implements Comparable<Entity> {
	const Entity({required this.id});

	// the 'new' name is reserved by the default constructor
	Entity.created({required Iterable<Object> core}) :
		id = Object.hashAll(core).toRadixString(36);

	final String id;

	@override
	bool operator ==(covariant Entity other) => id == other.id;

	@override
	int get hashCode => id.hashCode;
}
