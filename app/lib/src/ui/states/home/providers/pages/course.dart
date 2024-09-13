import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/course.dart';

part 'course.g.dart';


@riverpod
class CoursePageNotifier extends _$CoursePageNotifier {
	@override
	Course build(Course course) => course;

	void update(Course course) => state = course;
}
