import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/data/user_providers.dart';
import '../../user/domain/user_db.dart';
import 'view_group_bar.dart';

/// Displays a list of groups for which the currently signed in user is a member
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
