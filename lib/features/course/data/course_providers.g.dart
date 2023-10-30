// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseDatabaseHash() => r'9e94ffde039bf574e0403e490cab6cfaafffdd0d';

/// See also [courseDatabase].
@ProviderFor(courseDatabase)
final courseDatabaseProvider = AutoDisposeProvider<CourseDatabase>.internal(
  courseDatabase,
  name: r'courseDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CourseDatabaseRef = AutoDisposeProviderRef<CourseDatabase>;
String _$coursesHash() => r'8b5ffc38c1966fb6e016014e47c3b91e0289d48f';

/// See also [courses].
@ProviderFor(courses)
final coursesProvider = AutoDisposeStreamProvider<List<Course>>.internal(
  courses,
  name: r'coursesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$coursesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CoursesRef = AutoDisposeStreamProviderRef<List<Course>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
