import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// The data associated with courses.
@freezed
class Course with _$Course{
  const factory Course({
    required String name,
    required List<String>  students,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<Course>> checkInitialData() async {
    String content =
    await rootBundle.loadString("assets/initialData/courses.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Course.fromJson(jsonData)).toList();
  }
}