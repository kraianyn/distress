import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'courses.g.dart';


@Riverpod(keepAlive: true)
class CoursesNotifier extends _$CoursesNotifier {
	@override
	Future<List<Course>> build() async {
		return await ref.scheduleRepository.courses()..sort();
	}

	Future<void> add(Course course) async {
		await ref.scheduleRepository.addCourse(course);
		final courses = await future;
		state = AsyncValue.data(courses..add(course)..sort());
	}

	Future<FinishedCourse> finish(Course course, {required int studentCount}) async {
		final finishedCourse = await ref.scheduleRepository.finishCourse(course, studentCount);
		_updateCourseInState(finishedCourse);
		return finishedCourse;
	}

	Future<void> updateCourse(Course course) async {
		await ref.scheduleRepository.updateCourse(course);
		_updateCourseInState(course);
	}

	void _updateCourseInState(Course course) {
		final courses = state.value!;
		courses[courses.indexOf(course)] = course;
		state = AsyncValue.data(courses..sort());
	}

	Future<void> updateType(CourseType type) async {
		final courses = await future;
		final indexedTypeCourses = courses.indexed.where(
			(indexedCourse) => indexedCourse.$2.type == type
		);
		for (final (index, course) in indexedTypeCourses) {
			final updated = course.copyWith(type: type);
			courses[index] = updated;
		}
	}

	Future<void> updateLocation(Location location) async {
		final courses = await future;
		final indexedLocationCourses = courses.indexed.where(
			(indexedCourse) => indexedCourse.$2.location == location
		);
		for (final (index, course) in indexedLocationCourses) {
			final updated = course.copyWith(location: location);
			courses[index] = updated;
		}
	}

	Future<void> delete(Course course) async {
		await ref.scheduleRepository.deleteCourse(course);
		state = AsyncValue.data(state.value!..remove(course));
	}

	Future<void> deleteWithType(CourseType type) async {
		await ref.scheduleRepository.deleteCoursesWithType(type);
		await future;
		state.value!.removeWhere((c) => c.type == type);
	}

	Future<void> deleteWithLocation(Location location) async {
		await ref.scheduleRepository.deleteCoursesWithLocation(location);
		await future;
		state.value!.removeWhere((c) => c.location == location);
	}
}

extension Courses on AsyncValue<List<Course>> {
	Iterable<Course>? withType(CourseType type) => value?.where(
		(course) => course.type == type
	);

	Iterable<Course>? withDate(DateTime date) => value?.where(
		(course) => course.date == date
	);

	Iterable<Course>? withLocation(Location location) => value?.where(
		(course) => course.location == location
	);

	Iterable<Course>? withInstructor(Instructor instructor) => value?.where(
		(course) => course.instructors.contains(instructor)
	);
}
