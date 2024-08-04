import 'course_type.dart';
import 'instructor.dart';
import 'location.dart';


class Course {
	const Course({
		required this.id,
		required this.type,
		required this.date,
		required this.location,
		required this.instructors,
		this.note
	});

	final String id;
	final CourseType type;
	final DateTime date;
	final Location location;
	final List<Instructor> instructors;
	final String? note;
}
