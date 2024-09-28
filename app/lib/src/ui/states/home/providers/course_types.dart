import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/schedule_repository.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'course_types.g.dart';


@Riverpod(keepAlive: true)
class CourseTypesNotifier extends _$CourseTypesNotifier {
	@override
	Future<List<CourseType>> build() async {
		return await _repository.courseTypes()..sort();
	}

	Future<void> add(CourseType type) async {
		await _repository.addCourseType(type);
		final types = await future;
		state = AsyncValue.data(types..add(type)..sort());
	}

	// the 'update' name is reserved by the super class
	Future<void> updateType(CourseType type) async {
		await _repository.updateCourseType(type);
		_types[_types.indexOf(type)] = type;
		state = AsyncValue.data(_types);
		ref.coursesNotifier.updateType(type);
	}

	Future<void> delete(CourseType type) async {
		await ref.coursesNotifier.deleteWithType(type);
		await _repository.deleteCourseType(type);
		state = AsyncValue.data(_types..remove(type));
	}

	List<CourseType> get _types => state.value!;

	ScheduleRepository get _repository => ref.scheduleRepository();
}
