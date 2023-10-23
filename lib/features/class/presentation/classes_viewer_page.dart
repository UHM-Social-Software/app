import 'package:app/features/class/presentation/class_bar.dart';
import 'package:app/features/user/domain/user_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/data/user_providers.dart';

/// Displays a list of classes that the given studentID is in.
class ClassesViewerPage extends ConsumerWidget {
  const ClassesViewerPage({
    super.key,
    required this.studentID,
  });

  final String title = 'ClassesViewerPage';
  final String studentID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    UserData user = userDB.getUser(studentID);
    List<String> classNames = user.classes;

    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ...classNames.map((className) => ClassBar(className: className))
              ],
            ),
          ],
        ),
      ),
    );
  }
}