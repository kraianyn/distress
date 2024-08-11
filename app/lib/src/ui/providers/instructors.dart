import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repository.dart';
import 'package:distress/src/domain/instructor.dart';

import 'repository.dart';

part 'instructors.g.dart';


@Riverpod(keepAlive: true)
class InstructorsNotifier extends _$InstructorsNotifier {
	@override
	Future<List<Instructor>> build() async {
		return await ref.watch(repositoryProvider).instructors()..sort();
	}

	Future<void> add(Instructor instructor) async {
		await _repository.addInstructor(instructor);
		final instructors = await future;
		state = AsyncValue.data(instructors..add(instructor)..sort());
	}

	Future<void> delete(Instructor instructor) async {
		await _repository.deleteInstructor(instructor);
		state = AsyncValue.data(state.value!..remove(instructor));
	}

	Repository get _repository => ref.watch(repositoryProvider);
}
