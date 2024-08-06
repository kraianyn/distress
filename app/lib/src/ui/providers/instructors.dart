import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/instructor.dart';
import 'repository.dart';

part 'instructors.g.dart';


@Riverpod(keepAlive: true)
class InstructorsNotifier extends _$InstructorsNotifier {
	@override
	Future<List<Instructor>> build() async {
		return await ref.watch(repositoryProvider).instructors();
	}
}
