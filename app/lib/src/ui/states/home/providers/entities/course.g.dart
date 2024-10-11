// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseNotifierHash() => r'0f19434ba9cea9101207441de179872468099667';

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

abstract class _$CourseNotifier extends BuildlessAutoDisposeNotifier<Course> {
  late final Course course;

  Course build(
    Course course,
  );
}

/// See also [CourseNotifier].
@ProviderFor(CourseNotifier)
const courseNotifierProvider = CourseNotifierFamily();

/// See also [CourseNotifier].
class CourseNotifierFamily extends Family<Course> {
  /// See also [CourseNotifier].
  const CourseNotifierFamily();

  /// See also [CourseNotifier].
  CourseNotifierProvider call(
    Course course,
  ) {
    return CourseNotifierProvider(
      course,
    );
  }

  @override
  CourseNotifierProvider getProviderOverride(
    covariant CourseNotifierProvider provider,
  ) {
    return call(
      provider.course,
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
  String? get name => r'courseNotifierProvider';
}

/// See also [CourseNotifier].
class CourseNotifierProvider
    extends AutoDisposeNotifierProviderImpl<CourseNotifier, Course> {
  /// See also [CourseNotifier].
  CourseNotifierProvider(
    Course course,
  ) : this._internal(
          () => CourseNotifier()..course = course,
          from: courseNotifierProvider,
          name: r'courseNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseNotifierHash,
          dependencies: CourseNotifierFamily._dependencies,
          allTransitiveDependencies:
              CourseNotifierFamily._allTransitiveDependencies,
          course: course,
        );

  CourseNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.course,
  }) : super.internal();

  final Course course;

  @override
  Course runNotifierBuild(
    covariant CourseNotifier notifier,
  ) {
    return notifier.build(
      course,
    );
  }

  @override
  Override overrideWith(CourseNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CourseNotifierProvider._internal(
        () => create()..course = course,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        course: course,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CourseNotifier, Course> createElement() {
    return _CourseNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseNotifierProvider && other.course == course;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, course.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseNotifierRef on AutoDisposeNotifierProviderRef<Course> {
  /// The parameter `course` of this provider.
  Course get course;
}

class _CourseNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CourseNotifier, Course>
    with CourseNotifierRef {
  _CourseNotifierProviderElement(super.provider);

  @override
  Course get course => (origin as CourseNotifierProvider).course;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
