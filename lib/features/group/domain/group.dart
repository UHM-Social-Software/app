import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

/// The data associated with groups.
@freezed
class Group with _$Group{
  const factory Group({
    required String id,
    required String name,
    required String description,
    required String upcomingEvents,
    String? imagePath,
    required String owner,
    required List<String> membership,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<Group>> checkInitialData() async {
    String content =
    await rootBundle.loadString("assets/initialData/groups.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Group.fromJson(jsonData)).toList();
  }
}
