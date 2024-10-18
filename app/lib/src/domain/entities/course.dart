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
		required this.leadInstructor,
		this.note,
		this.studentCount
	});

	Course.added({
		required this.type,
		required this.date,
		required this.location,
		required this.instructors,
		required this.leadInstructor,
		this.note
	}) : studentCount = null,
		super.added(core: [type, date, location]);

	final CourseType type;
	final DateTime date;
	final Location location;
	final List<Instructor> instructors;
	final Instructor? leadInstructor;
	final String? note;
	final int? studentCount;

	Course copyWith({
		CourseType? type,
		DateTime? date,
		Location? location,
		List<Instructor>? instructors,
		Instructor? leadInstructor,
		String? note,
		int? studentCount
	}) => Course(
		id: id,
		type: type ?? this.type,
		date: date ?? this.date,
		location: location ?? this.location,
		instructors: instructors ?? this.instructors,
		leadInstructor: leadInstructor ?? this.leadInstructor,
		note: note ?? this.note,
		studentCount: studentCount ?? this.studentCount
	);

	@override
	int compareTo(covariant Course other) => date.compareTo(other.date);
}
