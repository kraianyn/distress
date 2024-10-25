import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'course_types.g.dart';


@Riverpod(keepAlive: true)
class CourseTypesNotifier extends _$CourseTypesNotifier {
	@override
	Future<List<CourseType>> build() async {
		return await ref.scheduleRepository.courseTypes()..sort();
	}

	Future<void> add(CourseType type) async {
		await ref.scheduleRepository.addCourseType(type);
		final types = await future;
		state = AsyncValue.data(types..add(type)..sort());
	}

	// the 'update' name is reserved by the super class
	Future<void> updateType(CourseType type) async {
		await ref.scheduleRepository.updateCourseType(type);

		final types = state.value!;
		types[types.indexOf(type)] = type;
		state = AsyncValue.data(types);

		await ref.coursesNotifier.updateType(type);
	}

	Future<void> incrementCourseCount(CourseType type) async {
		await ref.scheduleRepository.incrementCourseCount(type);
		ref.invalidateSelf();
		await future;
	}

	Future<void> delete(CourseType type) async {
		await ref.coursesNotifier.deleteWithType(type);
		await ref.scheduleRepository.deleteCourseType(type);
		state = AsyncValue.data(state.value!..remove(type));
	}
}
