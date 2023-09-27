import 'package:app/pages/home/views/settingsView/pages/edit_group_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../data_model/group_db.dart';
import '../../../../../data_model/user_db.dart';
import '../../profileView/components/group_bar.dart';
import 'edit_group.dart';

/// Displays a list of Gardens.
class MyGroups extends StatelessWidget {
  MyGroups({
    super.key,
  });

  static const routeName = '/my_groups';

  @override
  Widget build(BuildContext context) {
    List<String> groupNames = groupDB.getMyGroupNames(userDB.getUser(currentUserID).name);
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
                        ...groupNames.map((groupName) => EditGroupBar(groupName: groupName)),
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
