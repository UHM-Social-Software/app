import 'package:app/features/user/presentation/student_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/class_providers.dart';
import '../domain/class_db.dart';

/// Displays a list of Students in a class.
class ClassPage extends ConsumerWidget {
  const ClassPage({
    super.key,
    required this.className,
  });

  static const routeName = '/ClassPage';
  final String className;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ClassDB classDB = ref.watch(classDBProvider);
    List<String> studentIDs = classDB.getStudentIDs(className);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
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
                        ...studentIDs
                            .map((student) => StudentBar(userID: student))
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
