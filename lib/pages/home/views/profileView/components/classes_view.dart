import 'package:app/pages/home/views/profileView/components/class_bar.dart';
import 'package:app/data_model/user_db.dart';
import 'package:flutter/material.dart';

import '../pages/class_page.dart';

/// Displays a list of Gardens.
class ClassesView extends StatelessWidget {
  const ClassesView({
    super.key,
  });

  final String title = 'classesView';

  @override
  Widget build(BuildContext context) {
    UserData user = userDB.getUser(currentUserID);
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