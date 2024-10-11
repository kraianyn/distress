// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_type.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseTypeNotifierHash() =>
    r'ad41ac3556602c3166cf9fb11b59dfea490ad83d';

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

abstract class _$CourseTypeNotifier
    extends BuildlessAutoDisposeNotifier<CourseType> {
  late final CourseType type;

  CourseType build(
    CourseType type,
  );
}

/// See also [CourseTypeNotifier].
@ProviderFor(CourseTypeNotifier)
const courseTypeNotifierProvider = CourseTypeNotifierFamily();

/// See also [CourseTypeNotifier].
class CourseTypeNotifierFamily extends Family<CourseType> {
  /// See also [CourseTypeNotifier].
  const CourseTypeNotifierFamily();

  /// See also [CourseTypeNotifier].
  CourseTypeNotifierProvider call(
    CourseType type,
  ) {
    return CourseTypeNotifierProvider(
      type,
    );
  }

  @override
  CourseTypeNotifierProvider getProviderOverride(
    covariant CourseTypeNotifierProvider provider,
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
  String? get name => r'courseTypeNotifierProvider';
}

/// See also [CourseTypeNotifier].
class CourseTypeNotifierProvider
    extends AutoDisposeNotifierProviderImpl<CourseTypeNotifier, CourseType> {
  /// See also [CourseTypeNotifier].
  CourseTypeNotifierProvider(
    CourseType type,
  ) : this._internal(
          () => CourseTypeNotifier()..type = type,
          from: courseTypeNotifierProvider,
          name: r'courseTypeNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseTypeNotifierHash,
          dependencies: CourseTypeNotifierFamily._dependencies,
          allTransitiveDependencies:
              CourseTypeNotifierFamily._allTransitiveDependencies,
          type: type,
        );

  CourseTypeNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final CourseType type;

  @override
  CourseType runNotifierBuild(
    covariant CourseTypeNotifier notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(CourseTypeNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CourseTypeNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<CourseTypeNotifier, CourseType>
      createElement() {
    return _CourseTypeNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseTypeNotifierProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseTypeNotifierRef on AutoDisposeNotifierProviderRef<CourseType> {
  /// The parameter `type` of this provider.
  CourseType get type;
}

class _CourseTypeNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CourseTypeNotifier, CourseType>
    with CourseTypeNotifierRef {
  _CourseTypeNotifierProviderElement(super.provider);

  @override
  CourseType get type => (origin as CourseTypeNotifierProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
