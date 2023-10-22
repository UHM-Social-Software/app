import 'package:app/pages/home/views/profileView/pages/student_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data_model/class_db.dart';


/// Displays a list of Gardens.
class ClassPage extends ConsumerWidget {
  ClassPage({
    super.key, required this.className,
  });

  static const routeName = '/class';
  String className;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ClassDB classDB = ref.watch(classDBProvider);
    List<String> studentIDs = classDB.getStudentIDs(className);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 95, 70, 1.0),
        title: Text(className),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ...studentIDs.map((student) => StudentBar(userID: student))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        ),
      );
  }
}

class Class {
  late List<Student> students;
}

class Student {
  late final String name;
  late final String major;
  late final String imgUrl;
}
