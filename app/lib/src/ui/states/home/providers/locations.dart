import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/entities/location.dart';
import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'locations.g.dart';


@Riverpod(keepAlive: true)
class LocationsNotifier extends _$LocationsNotifier {
	@override
	Future<List<Location>> build() async {
		return await ref.scheduleRepository.locations()..sort();
	}

	Future<void> add(Location location) async {
		await ref.scheduleRepository.addLocation(location);
		final locations = await future;
		state = AsyncValue.data(locations..add(location)..sort());
	}

	// the 'update' name is reserved by the super class
	Future<void> updateLocation(Location location) async {
		await ref.scheduleRepository.updateLocation(location);

		final locations = state.value!;
		locations[locations.indexOf(location)] = location;
		state = AsyncValue.data(locations);

		await ref.coursesNotifier.updateLocation(location);
	}

	Future<void> delete(Location location) async {
		await ref.coursesNotifier.deleteWithLocation(location);
		await ref.scheduleRepository.deleteLocation(location);
		state = AsyncValue.data(state.value!..remove(location));
	}
}
