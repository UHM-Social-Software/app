import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/class_page.dart';
import '../pages/group_page.dart';
import '../../../../../data_model/user_db.dart';
import 'group_bar.dart';

class GroupsView extends ConsumerWidget {
  const GroupsView({
    super.key,
  });

  final String title = 'groupsView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    List<String> groupIDs = userDB.getUserGroups(currentUserID);

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
