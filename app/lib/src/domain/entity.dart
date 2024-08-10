abstract class Entity implements Comparable<Entity> {
	const Entity({required this.id});

	// the 'new' name is reserved by the default constructor
	Entity.created({required List<Object> core}) :
		id = Object.hashAll(core).toRadixString(36);

	final String id;

	@override
	int compareTo(Entity other);
}
