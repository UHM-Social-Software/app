import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// The data associated with users.
@freezed
class User with _$User{
  const factory User({
    required String id,
    required String name,
    required String email,
    String? bio,
    required List<String> classes,
    List<String>?interests,
    required List<String> groups,
    String? imagePath,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<User>> checkInitialData() async {
    String content =
    await rootBundle.loadString("assets/initialData/users.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => User.fromJson(jsonData)).toList();
  }
}