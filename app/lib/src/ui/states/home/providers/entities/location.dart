import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/domain/entities/location.dart';

part 'location.g.dart';


@riverpod
class LocationNotifier extends _$LocationNotifier {
	@override
	Location build(Location location) => location;

	void update(Location location) => state = location;
}
