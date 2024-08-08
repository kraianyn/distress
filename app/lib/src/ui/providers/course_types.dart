import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repository.dart';
import 'package:distress/src/domain/course_type.dart';

import 'repository.dart';

part 'course_types.g.dart';


@Riverpod(keepAlive: true)
class CourseTypesNotifier extends _$CourseTypesNotifier {
	@override
	Future<List<CourseType>> build() async {
		return await _repository.courseTypes();
	}

	Future<void> add(CourseType type) async {
		await _repository.addCourseType(type);
		final currentState = await future;
		state = AsyncValue.data([...currentState, type]);
	}

	Future<void> delete(CourseType type) async {
		await _repository.deleteCourseType(type);
		state = AsyncValue.data(state.value!..remove(type));
	}

	Repository get _repository => ref.watch(repositoryProvider);
}
