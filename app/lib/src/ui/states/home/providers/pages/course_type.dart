import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/course_type.dart';

part 'course_type.g.dart';


@riverpod
class CourseTypePageNotifier extends _$CourseTypePageNotifier {
	@override
	CourseType build(CourseType type) => type;

	void update(CourseType type) => state = type;
}
