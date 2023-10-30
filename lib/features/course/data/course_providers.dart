import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/course.dart';
import 'course_database.dart';

part 'course_providers.g.dart';

/*
final classDBProvider = Provider<ClassDB>((ref) {
  return ClassDB(ref);
});

 */

@riverpod
CourseDatabase courseDatabase(CourseDatabaseRef ref) {
  return CourseDatabase(ref);
}

@riverpod
Stream<List<Course>> courses(CoursesRef ref) {
  final database = ref.watch(courseDatabaseProvider);
  return database.watchCourses();
}