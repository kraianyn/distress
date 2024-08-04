import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/instructor.dart';
import 'repository.dart';

part 'instructors.g.dart';


@Riverpod(keepAlive: true)
class InstructorsNotifier extends _$InstructorsNotifier {
	@override
	FutureOr<List<Instructor>> build() async {
		return ref.watch(repositoryProvider).instructors();
	}
}
