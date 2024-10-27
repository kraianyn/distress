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
		this.note
	});

	Course.added({
		required this.type,
		required this.date,
		required this.location,
		required this.instructors,
		required this.leadInstructor,
		this.note
	}) :
		super.added(core: [type, date, location]);

	final CourseType type;
	final DateTime date;
	final Location location;
	final List<Instructor> instructors;
	final Instructor? leadInstructor;
	final String? note;

	FinishedCourse finished({
		required int number,
		required int studentCount
	}) => FinishedCourse(
		id: id,
		type: type,
		date: date,
		location: location,
		instructors: instructors,
		leadInstructor: leadInstructor,
		number: number,
		studentCount: studentCount
	);

	Course copyWith({
		CourseType? type,
		DateTime? date,
		Location? location,
		List<Instructor>? instructors,
		Instructor? leadInstructor,
		String? note
	}) => Course(
		id: id,
		type: type ?? this.type,
		date: date ?? this.date,
		location: location ?? this.location,
		instructors: instructors ?? this.instructors,
		leadInstructor: leadInstructor ?? this.leadInstructor,
		note: note ?? this.note
	);

	@override
	int compareTo(covariant Course other) => date.compareTo(other.date);
}

class FinishedCourse extends Course {
	const FinishedCourse({
		required super.id,
		required super.type,
		required super.date,
		required super.location,
		required super.instructors,
		required super.leadInstructor,
		super.note,
		required this.number,
		required this.studentCount
	});

	final int number;
	final int studentCount;
}
