import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/course.dart';
import 'repository.dart';

part 'courses.g.dart';


@Riverpod(keepAlive: true)
class CoursesNotifier extends _$CoursesNotifier {
	@override
	Future<List<Course>> build() async {
		return await ref.watch(repositoryProvider).courses();
	}
}
