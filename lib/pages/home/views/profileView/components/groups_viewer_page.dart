import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/class_page.dart';
import '../pages/group_page.dart';
import '../../../../../data_model/user_db.dart';
import 'group_bar.dart';

class GroupsViewerPage extends ConsumerWidget {
  const GroupsViewerPage({
    super.key,
    required this.studentID,
  });

  final String title = 'GroupsViewerPage';
  final String studentID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    List<String> groupIDs = userDB.getUserGroups(studentID);

    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ...groupIDs.map((groupID) => GroupBar(groupID: groupID)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
