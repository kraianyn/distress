import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/schedule_repository.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';

import 'schedule_repository.dart';

part 'courses.g.dart';


@Riverpod(keepAlive: true)
class CoursesNotifier extends _$CoursesNotifier {
	@override
	Future<List<Course>> build() async {
		return await ref.watch(scheduleRepositoryProvider).courses()..sort();
	}

	Future<void> add(Course course) async {
		await _repository.addCourse(course);
		final courses = await future;
		state = AsyncValue.data(courses..add(course)..sort());
	}

	Future<void> updateCourse(Course course) async {
		await _repository.updateCourse(course);
		_courses[_courses.indexOf(course)] = course;
		state = AsyncValue.data(_courses);
	}

	void updateType(CourseType type) {
		final indexedTypeCourses = _courses.indexed.where(
			(indexedCourse) => indexedCourse.$2.type == type
		);
		for (final (index, course) in indexedTypeCourses) {
			_courses[index] = course.copyWith(type: type);
		}
	}

	void updateLocation(Location location) {
		final indexedLocationCourses = _courses.indexed.where(
			(indexedCourse) => indexedCourse.$2.location == location
		);
		for (final (index, course) in indexedLocationCourses) {
			_courses[index] = course.copyWith(location: location);
		}
	}

	Future<void> delete(Course course) async {
		await _repository.deleteCourse(course);
		state = AsyncValue.data(_courses..remove(course));
	}

	Future<void> deleteWithType(CourseType type) async {
		await _repository.deleteCoursesWithType(type);
		_courses.removeWhere((c) => c.type == type);
	}

	Future<void> deleteWithLocation(Location location) async {
		await _repository.deleteCoursesWithLocation(location);
		_courses.removeWhere((c) => c.location == location);
	}

	Future<void> removeInstructor(Instructor instructor) async {
		await _repository.removeInstructorFromCourses(instructor);
		for (final course in _courses) {
			course.instructors.remove(instructor);
		}
	}

	List<Course> get _courses => state.value!;

	ScheduleRepository get _repository => ref.watch(scheduleRepositoryProvider);
}
