import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/schedule_repository.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'instructors.g.dart';


@Riverpod(keepAlive: true)
class InstructorsNotifier extends _$InstructorsNotifier {
	@override
	Future<List<Instructor>> build() async {
		return await _repository.instructors()..sort();
	}

	Future<void> add(Instructor instructor) async {
		await _repository.addInstructor(instructor);
		final instructors = await future;
		state = AsyncValue.data(instructors..add(instructor)..sort());
	}

	Future<void> delete(Instructor instructor) async {
		await ref.coursesNotifier.removeInstructor(instructor);
		await _repository.deleteInstructor(instructor);
		state = AsyncValue.data(state.value!..remove(instructor));
	}

	ScheduleRepository get _repository => ref.scheduleRepository();
}
