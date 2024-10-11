// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationNotifierHash() => r'a0397830797dff3a84fd4024bef74293becd1be9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$LocationNotifier
    extends BuildlessAutoDisposeNotifier<Location> {
  late final Location location;

  Location build(
    Location location,
  );
}

/// See also [LocationNotifier].
@ProviderFor(LocationNotifier)
const locationNotifierProvider = LocationNotifierFamily();

/// See also [LocationNotifier].
class LocationNotifierFamily extends Family<Location> {
  /// See also [LocationNotifier].
  const LocationNotifierFamily();

  /// See also [LocationNotifier].
  LocationNotifierProvider call(
    Location location,
  ) {
    return LocationNotifierProvider(
      location,
    );
  }

  @override
  LocationNotifierProvider getProviderOverride(
    covariant LocationNotifierProvider provider,
  ) {
    return call(
      provider.location,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'locationNotifierProvider';
}

/// See also [LocationNotifier].
class LocationNotifierProvider
    extends AutoDisposeNotifierProviderImpl<LocationNotifier, Location> {
  /// See also [LocationNotifier].
  LocationNotifierProvider(
    Location location,
  ) : this._internal(
          () => LocationNotifier()..location = location,
          from: locationNotifierProvider,
          name: r'locationNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$locationNotifierHash,
          dependencies: LocationNotifierFamily._dependencies,
          allTransitiveDependencies:
              LocationNotifierFamily._allTransitiveDependencies,
          location: location,
        );

  LocationNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.location,
  }) : super.internal();

  final Location location;

  @override
  Location runNotifierBuild(
    covariant LocationNotifier notifier,
  ) {
    return notifier.build(
      location,
    );
  }

  @override
  Override overrideWith(LocationNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: LocationNotifierProvider._internal(
        () => create()..location = location,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        location: location,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<LocationNotifier, Location>
      createElement() {
    return _LocationNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocationNotifierProvider && other.location == location;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, location.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LocationNotifierRef on AutoDisposeNotifierProviderRef<Location> {
  /// The parameter `location` of this provider.
  Location get location;
}

class _LocationNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<LocationNotifier, Location>
    with LocationNotifierRef {
  _LocationNotifierProviderElement(super.provider);

  @override
  Location get location => (origin as LocationNotifierProvider).location;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
