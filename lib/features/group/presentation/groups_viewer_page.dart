import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user_db.dart';
import 'view_group_bar.dart';

/// Display a list of groups for which the given studentID is a member
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
