// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_type.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseTypePageNotifierHash() =>
    r'c15514ad57d2ef0b1284ccd37301ea1a00c63ab1';

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

abstract class _$CourseTypePageNotifier
    extends BuildlessAutoDisposeNotifier<CourseType> {
  late final CourseType type;

  CourseType build(
    CourseType type,
  );
}

/// See also [CourseTypePageNotifier].
@ProviderFor(CourseTypePageNotifier)
const courseTypePageNotifierProvider = CourseTypePageNotifierFamily();

/// See also [CourseTypePageNotifier].
class CourseTypePageNotifierFamily extends Family<CourseType> {
  /// See also [CourseTypePageNotifier].
  const CourseTypePageNotifierFamily();

  /// See also [CourseTypePageNotifier].
  CourseTypePageNotifierProvider call(
    CourseType type,
  ) {
    return CourseTypePageNotifierProvider(
      type,
    );
  }

  @override
  CourseTypePageNotifierProvider getProviderOverride(
    covariant CourseTypePageNotifierProvider provider,
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
  String? get name => r'courseTypePageNotifierProvider';
}

/// See also [CourseTypePageNotifier].
class CourseTypePageNotifierProvider extends AutoDisposeNotifierProviderImpl<
    CourseTypePageNotifier, CourseType> {
  /// See also [CourseTypePageNotifier].
  CourseTypePageNotifierProvider(
    CourseType type,
  ) : this._internal(
          () => CourseTypePageNotifier()..type = type,
          from: courseTypePageNotifierProvider,
          name: r'courseTypePageNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseTypePageNotifierHash,
          dependencies: CourseTypePageNotifierFamily._dependencies,
          allTransitiveDependencies:
              CourseTypePageNotifierFamily._allTransitiveDependencies,
          type: type,
        );

  CourseTypePageNotifierProvider._internal(
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
    covariant CourseTypePageNotifier notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(CourseTypePageNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CourseTypePageNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<CourseTypePageNotifier, CourseType>
      createElement() {
    return _CourseTypePageNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseTypePageNotifierProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseTypePageNotifierRef on AutoDisposeNotifierProviderRef<CourseType> {
  /// The parameter `type` of this provider.
  CourseType get type;
}

class _CourseTypePageNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CourseTypePageNotifier,
        CourseType> with CourseTypePageNotifierRef {
  _CourseTypePageNotifierProviderElement(super.provider);

  @override
  CourseType get type => (origin as CourseTypePageNotifierProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
