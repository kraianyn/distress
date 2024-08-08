import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repository.dart';
import 'package:distress/src/domain/location.dart';

import 'repository.dart';

part 'locations.g.dart';


@Riverpod(keepAlive: true)
class LocationsNotifier extends _$LocationsNotifier {
	@override
	Future<List<Location>> build() async {
		return await ref.watch(repositoryProvider).locations();
	}

	Future<void> add(Location location) async {
		await _repository.addLocation(location);
		final currentState = await future;
		state = AsyncValue.data([...currentState, location]);
	}

	Future<void> delete(Location location) async {
		await _repository.deleteLocation(location);
		state = AsyncValue.data(state.value!..remove(location));
	}

	Repository get _repository => ref.watch(repositoryProvider);
}
