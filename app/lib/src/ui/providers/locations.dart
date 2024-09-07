import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/schedule_repository.dart';
import 'package:distress/src/domain/location.dart';

import 'schedule_repository.dart';

part 'locations.g.dart';


@Riverpod(keepAlive: true)
class LocationsNotifier extends _$LocationsNotifier {
	@override
	Future<List<Location>> build() async {
		return await ref.watch(repositoryProvider).locations()..sort();
	}

	Future<void> add(Location location) async {
		await _repository.addLocation(location);
		final locations = await future;
		state = AsyncValue.data(locations..add(location)..sort());
	}

	// the 'update' name is reserved by the super class
	Future<void> updateLocation(Location location) async {
		await _repository.updateLocation(location);
		_locations[_locations.indexOf(location)] = location;
		state = AsyncValue.data(_locations);
	}

	Future<void> delete(Location location) async {
		await _repository.deleteLocation(location);
		state = AsyncValue.data(state.value!..remove(location));
	}

	List<Location> get _locations => state.value!;

	ScheduleRepository get _repository => ref.watch(repositoryProvider);
}
