// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coursePageNotifierHash() =>
    r'f6b80014dbc5beb86e8b2011ea02a856c1ba9a7a';

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

abstract class _$CoursePageNotifier
    extends BuildlessAutoDisposeNotifier<Course> {
  late final Course course;

  Course build(
    Course course,
  );
}

/// See also [CoursePageNotifier].
@ProviderFor(CoursePageNotifier)
const coursePageNotifierProvider = CoursePageNotifierFamily();

/// See also [CoursePageNotifier].
class CoursePageNotifierFamily extends Family<Course> {
  /// See also [CoursePageNotifier].
  const CoursePageNotifierFamily();

  /// See also [CoursePageNotifier].
  CoursePageNotifierProvider call(
    Course course,
  ) {
    return CoursePageNotifierProvider(
      course,
    );
  }

  @override
  CoursePageNotifierProvider getProviderOverride(
    covariant CoursePageNotifierProvider provider,
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
  String? get name => r'coursePageNotifierProvider';
}

/// See also [CoursePageNotifier].
class CoursePageNotifierProvider
    extends AutoDisposeNotifierProviderImpl<CoursePageNotifier, Course> {
  /// See also [CoursePageNotifier].
  CoursePageNotifierProvider(
    Course course,
  ) : this._internal(
          () => CoursePageNotifier()..course = course,
          from: coursePageNotifierProvider,
          name: r'coursePageNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$coursePageNotifierHash,
          dependencies: CoursePageNotifierFamily._dependencies,
          allTransitiveDependencies:
              CoursePageNotifierFamily._allTransitiveDependencies,
          course: course,
        );

  CoursePageNotifierProvider._internal(
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
    covariant CoursePageNotifier notifier,
  ) {
    return notifier.build(
      course,
    );
  }

  @override
  Override overrideWith(CoursePageNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CoursePageNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<CoursePageNotifier, Course>
      createElement() {
    return _CoursePageNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoursePageNotifierProvider && other.course == course;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, course.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CoursePageNotifierRef on AutoDisposeNotifierProviderRef<Course> {
  /// The parameter `course` of this provider.
  Course get course;
}

class _CoursePageNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CoursePageNotifier, Course>
    with CoursePageNotifierRef {
  _CoursePageNotifierProviderElement(super.provider);

  @override
  Course get course => (origin as CoursePageNotifierProvider).course;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
