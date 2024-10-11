import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/entities/course.dart';

part 'course.g.dart';


@riverpod
class CourseNotifier extends _$CourseNotifier {
	@override
	Course build(Course course) => course;

	void update(Course course) => state = course;
}
