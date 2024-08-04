import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/location.dart';
import 'repository.dart';

part 'locations.g.dart';


@Riverpod(keepAlive: true)
class LocationsNotifier extends _$LocationsNotifier {
	@override
	FutureOr<List<Location>> build() async {
		return ref.watch(repositoryProvider).locations();
	}
}
