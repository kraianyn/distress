import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:distress/src/domain/location.dart';

part 'location.g.dart';


@riverpod
class LocationPageNotifier extends _$LocationPageNotifier {
	@override
	Location build(Location type) => type;

	void update(Location type) => state = type;
}
