import 'course_type.dart';
import 'entity.dart';
import 'instructor.dart';
import 'location.dart';


class Course extends Entity {
	const Course({
		required super.id,
		required this.type,
		required this.date,
		required this.location,
		required this.instructors,
		this.note
	});

	Course.created({
		required this.type,
		required this.date,
		required this.location,
		required this.instructors,
		this.note
	}) : super.created(core: [type, date, location]);

	final CourseType type;
	final DateTime date;
	final Location location;
	final List<Instructor> instructors;
	final String? note;

	Course copyWith({
		CourseType? type,
		DateTime? date,
		Location? location,
		List<Instructor>? instructors,
		String? note
	}) => Course(
		id: id,
		type: type ?? this.type,
		date: date ?? this.date,
		location: location ?? this.location,
		instructors: instructors ?? this.instructors,
		note: note ?? this.note
	);

	@override
	int compareTo(covariant Course other) => date.compareTo(other.date);
}
