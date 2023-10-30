import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/course.dart';

/// Provides access to the Firestore database storing [Course] documents.
class CourseDatabase {
  CourseDatabase(this.ref);

  final ProviderRef<CourseDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Course>> watchCourses() => _service.watchCollection(
      path: FirestorePath.courses(),
      builder: (data, documentId) => Course.fromJson(data!));

  Stream<Course> watchCourse(String courseId) => _service.watchDocument(
      path: FirestorePath.course(courseId),
      builder: (data, documentId) => Course.fromJson(data!));

  Future<List<Course>> fetchCourses() => _service.fetchCollection(
      path: FirestorePath.courses(),
      builder: (data, documentId) => Course.fromJson(data!));

  Future<Course> fetchCourse(String courseId) => _service.fetchDocument(
      path: FirestorePath.course(courseId),
      builder: (data, documentId) => Course.fromJson(data!));

  Future<void> setCourseError(Course course) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());
}
