import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/schedule_repository.dart';
import 'package:distress/src/domain/entities/location.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'locations.g.dart';


@Riverpod(keepAlive: true)
class LocationsNotifier extends _$LocationsNotifier {
	@override
	Future<List<Location>> build() async {
		return await _repository.locations()..sort();
	}

	Future<void> add(Location location) async {
		await _repository.addLocation(location);
		final locations = await future;
		state = AsyncValue.data(locations..add(location)..sort());
	}

	// the 'update' name is reserved by the super class
	Future<void> updateLocation(Location location) async {
		await _repository.updateLocation(location);
		ref.coursesNotifier.updateLocation(location);
		_locations[_locations.indexOf(location)] = location;
		state = AsyncValue.data(_locations);
	}

	Future<void> delete(Location location) async {
		await ref.coursesNotifier.deleteWithLocation(location);
		await _repository.deleteLocation(location);
		state = AsyncValue.data(state.value!..remove(location));
	}

	List<Location> get _locations => state.value!;

	ScheduleRepository get _repository => ref.scheduleRepository();
}
