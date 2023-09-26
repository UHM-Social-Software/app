import 'package:flutter/material.dart';

import '../pages/class_page.dart';
import '../pages/group_page.dart';
import '../../../../../data_model/user_db.dart';
import 'group_bar.dart';

/// Displays a list of Gardens.
class GroupsView extends StatelessWidget {
  const GroupsView({
    super.key,
  });

  final String title = 'groupsView';

  @override
  Widget build(BuildContext context) {
    List<String> groupNames = userDB.getUserGroups(currentUserID);

    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ...groupNames.map((groupName) => GroupBar(groupName: groupName)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
