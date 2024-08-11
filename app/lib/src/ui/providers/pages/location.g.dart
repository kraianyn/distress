// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationPageNotifierHash() =>
    r'dcb53e1ef5ca0213e4032ca55ba96dd185895502';

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

abstract class _$LocationPageNotifier
    extends BuildlessAutoDisposeNotifier<Location> {
  late final Location type;

  Location build(
    Location type,
  );
}

/// See also [LocationPageNotifier].
@ProviderFor(LocationPageNotifier)
const locationPageNotifierProvider = LocationPageNotifierFamily();

/// See also [LocationPageNotifier].
class LocationPageNotifierFamily extends Family<Location> {
  /// See also [LocationPageNotifier].
  const LocationPageNotifierFamily();

  /// See also [LocationPageNotifier].
  LocationPageNotifierProvider call(
    Location type,
  ) {
    return LocationPageNotifierProvider(
      type,
    );
  }

  @override
  LocationPageNotifierProvider getProviderOverride(
    covariant LocationPageNotifierProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'locationPageNotifierProvider';
}

/// See also [LocationPageNotifier].
class LocationPageNotifierProvider
    extends AutoDisposeNotifierProviderImpl<LocationPageNotifier, Location> {
  /// See also [LocationPageNotifier].
  LocationPageNotifierProvider(
    Location type,
  ) : this._internal(
          () => LocationPageNotifier()..type = type,
          from: locationPageNotifierProvider,
          name: r'locationPageNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$locationPageNotifierHash,
          dependencies: LocationPageNotifierFamily._dependencies,
          allTransitiveDependencies:
              LocationPageNotifierFamily._allTransitiveDependencies,
          type: type,
        );

  LocationPageNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final Location type;

  @override
  Location runNotifierBuild(
    covariant LocationPageNotifier notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(LocationPageNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: LocationPageNotifierProvider._internal(
        () => create()..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<LocationPageNotifier, Location>
      createElement() {
    return _LocationPageNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocationPageNotifierProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LocationPageNotifierRef on AutoDisposeNotifierProviderRef<Location> {
  /// The parameter `type` of this provider.
  Location get type;
}

class _LocationPageNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<LocationPageNotifier, Location>
    with LocationPageNotifierRef {
  _LocationPageNotifierProviderElement(super.provider);

  @override
  Location get type => (origin as LocationPageNotifierProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
