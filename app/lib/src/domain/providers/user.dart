import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';


@Riverpod(keepAlive: true, dependencies: [])
class UserIdNotifier extends _$UserIdNotifier {
	@override
	String? build() => null;

	void set(String id) => state = id;
}
