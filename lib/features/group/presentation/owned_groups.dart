import 'package:app/features/group/presentation/edit_group_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/group_providers.dart';
import '../domain/group_db.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user_db.dart';

/// Displays a list of groups for which the currently signed in user is the owner
class MyGroups extends ConsumerWidget {
  const MyGroups({
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
        backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
        title: const Text('My Groups'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Tap To Edit:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  SizedBox(width: 230),
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
