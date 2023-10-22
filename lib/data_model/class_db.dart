import 'package:app/data_model/user_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  ClassDB(this.ref);
  final ProviderRef<ClassDB> ref;
  final List<ClassData> _classes = [
    ClassData(
      name: 'ICS 491',
      students: [
        'user-001',
        'user-002',
        'user-003',
      ],
    ),
    ClassData(
      name: 'ICS 691D',
      students: [
        'user-001',
      ],
    ),
    ClassData(
      name: 'ICS 691E',
      students: [
        'user-001',
      ],
    ),
    ClassData(
      name: 'ICS 690',
      students: [
        'user-001',
      ],
    ),
    ClassData(
      name: 'ICS 622',
      students: [
        'user-001',
        'user-002',
      ],
    ),
    ClassData(
      name: 'ICS 613',
      students: [
        'user-001',
        'user-002',
      ],
    ),
    ClassData(
      name: 'ICS 314',
      students: [
        'user-003',
      ],
    ),
    ClassData(
      name: 'ICS 311',
      students: [
        'user-003',
      ],
    ),
  ];

  ClassData getClass(String className) {
    return _classes.firstWhere((classData) => classData.name == className);
  }

  List<ClassData> getClasses(UserData user) {
    return _classes
        .where((classData) => classData.students.contains(user.name))
        .toList();
  }

  List<String> getStudentIDs(String className){
    return _classes.firstWhere((classData) => classData.name == className).students;
  }
}

final classDBProvider = Provider<ClassDB>((ref) {
  return ClassDB(ref);
});