import 'package:app/data_model/user_db.dart';

/// The data associated with users.
class ClassData {
  ClassData({
    required this.name,
    required this.students,
  });

  String name;
  List<String> students;
}

/// Provides access to and operations on all defined users.
class ClassDB {
  final List<ClassData> _classes = [
    ClassData(
      name: 'ICS 491',
      students: [
        'Justin Lisoway',
        'Bob McDonald',
        'Donny Boy',
      ],
    ),
    ClassData(
      name: 'ICS 691D',
      students: [
        'Justin Lisoway',
      ],
    ),
    ClassData(
      name: 'ICS 691E',
      students: [
        'Justin Lisoway',
      ],
    ),
    ClassData(
      name: 'ICS 690',
      students: [
        'Justin Lisoway',
      ],
    ),
    ClassData(
      name: 'ICS 622',
      students: [
        'Justin Lisoway',
        'Donny Boy',
      ],
    ),
    ClassData(
      name: 'ICS 613',
      students: [
        'Justin Lisoway',
        'Donny Boy',
      ],
    ),
    ClassData(
      name: 'ICS 314',
      students: [
        'Bob McDonald',
      ],
    ),
    ClassData(
      name: 'ICS 311',
      students: [
        'Bob McDonald',
      ],
    ),
  ];

  ClassData getClass(String className) {
    return _classes.firstWhere((classData) => classData.name == className);
  }

  List<ClassData> getClasses(UserData user) {
    return _classes.where((classData) => classData.students.contains(user.name)).toList();
  }

  /// The singleton instance providing access to all user data for clients.
  ClassDB classDB = ClassDB();
}
