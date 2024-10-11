import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/entities/course_type.dart';

part 'course_type.g.dart';


@riverpod
class CourseTypeNotifier extends _$CourseTypeNotifier {
	@override
	CourseType build(CourseType type) => type;

	void update(CourseType type) => state = type;
}
