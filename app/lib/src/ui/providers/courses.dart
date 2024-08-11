import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repository.dart';

import 'package:distress/src/domain/course.dart';
import 'package:distress/src/domain/course_type.dart';
import 'package:distress/src/domain/instructor.dart';
import 'package:distress/src/domain/location.dart';

import 'repository.dart';

part 'courses.g.dart';


@Riverpod(keepAlive: true)
class CoursesNotifier extends _$CoursesNotifier {
	@override
	Future<List<Course>> build() async {
		return await ref.watch(repositoryProvider).courses()..sort();
	}

	Future<void> add(Course course) async {
		await _repository.addCourse(course);
		final courses = await future;
		state = AsyncValue.data(courses..add(course)..sort());
	}

	void updateType(CourseType type) {
		final indexedTypeCourses = _courses.indexed.where((c) => c.$2.type == type);
		for (final (index, course) in indexedTypeCourses) {
			_courses[index] = course.copyWith(type: type);
		}
	}

	Future<void> delete(Course course) async {
		await _repository.deleteCourse(course);
		state = AsyncValue.data(_courses..remove(course));
	}

	Future<void> deleteWithType(CourseType type) async {
		await _repository.deleteCoursesWithType(type);
		state = AsyncValue.data(_courses..removeWhere((c) => c.type == type));
	}

	Future<void> deleteWithLocation(Location location) async {
		await _repository.deleteCoursesWithLocation(location);
		state = AsyncValue.data(_courses..removeWhere((c) => c.location == location));
	}

	Future<void> removeInstructor(Instructor instructor) async {
		await _repository.removeInstructorFromCourses(instructor);
		for (final course in _courses) {
			course.instructors.remove(instructor);
		}
	}

	List<Course> get _courses => state.value!;

	Repository get _repository => ref.watch(repositoryProvider);
}
