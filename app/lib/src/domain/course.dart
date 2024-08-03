import 'course_type.dart';
import 'instructor.dart';
import 'location.dart';


class Course {
	const Course({
		required this.type,
		required this.date,
		required this.location,
		required this.instructors
	});

	final CourseType type;
	final DateTime date;
	final Location location;
	final List<Instructor> instructors;
}
