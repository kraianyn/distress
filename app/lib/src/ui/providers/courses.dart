import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repository.dart';
import 'package:distress/src/domain/course.dart';

import 'repository.dart';

part 'courses.g.dart';


@Riverpod(keepAlive: true)
class CoursesNotifier extends _$CoursesNotifier {
	@override
	Future<List<Course>> build() async {
		return await ref.watch(repositoryProvider).courses();
	}

Future<void> add(Course course) async {
		await _repository.addCourse(course);
		final currentState = await future;
		state = AsyncValue.data([...currentState, course]);
	}

	Repository get _repository => ref.watch(repositoryProvider);
}
