abstract class Entity implements Comparable<Entity> {
	const Entity({required this.id});

	final String id;

	@override
	int compareTo(Entity other);
}
