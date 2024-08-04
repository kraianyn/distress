import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/course_type.dart';
import 'repository.dart';

part 'course_types.g.dart';


@Riverpod(keepAlive: true)
class CourseTypesNotifier extends _$CourseTypesNotifier {
	@override
	FutureOr<List<CourseType>> build() async {
		return ref.watch(repositoryProvider).courseTypes();
	}
}
