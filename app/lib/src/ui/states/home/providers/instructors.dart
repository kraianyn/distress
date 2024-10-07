import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'instructors.g.dart';


@Riverpod(keepAlive: true)
class InstructorsNotifier extends _$InstructorsNotifier {
	@override
	Future<List<Instructor>> build() async {
		return await ref.scheduleRepository.instructors()..sort();
	}

	Future<void> add(Instructor instructor) async {
		await ref.scheduleRepository.addInstructor(instructor);
		final instructors = await future;
		state = AsyncValue.data(instructors..add(instructor)..sort());
	}
}
