import 'package:app/pages/home/views/settingsView/pages/edit_group_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data_model/group_db.dart';
import '../../../../../data_model/user_db.dart';
import '../../profileView/components/group_bar.dart';
import 'edit_group.dart';

/// Displays a list of Gardens.
class MyGroups extends ConsumerWidget {
  MyGroups({
    super.key,
  });

  static const routeName = '/my_groups';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final UserDB userDB = ref.watch(userDBProvider);
    final GroupDB groupDB = ref.watch(groupDBProvider);
    List<String> groupIDs = groupDB.getMyGroupIDs(userDB.getUser(currentUserID).id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 95, 70, 1.0),
        title: Text('My Groups'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Tap To Edit:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  const SizedBox(width: 230),
                ],
              ),
              const SizedBox(height: 10.0),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ...groupIDs.map((groupID) => EditGroupBar(groupID: groupID)),
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
