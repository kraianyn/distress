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

	final CourseType type;
	final DateTime date;
	final Location location;
	final List<Instructor> instructors;
	final String? note;
}
