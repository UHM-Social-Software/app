import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/group_providers.dart';
import '../domain/group_db.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user_db.dart';

/// Displays group home page given a group ID.
class GroupPage extends ConsumerWidget {
  const GroupPage({
    super.key,
    required this.groupID,
  });

  static const routeName = '/group';
  final String groupID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupDB groupDB = ref.watch(groupDBProvider);
    final UserDB userDB = ref.watch(userDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    GroupData group = groupDB.getGroup(groupID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            // Group Image
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(group.imagePath.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            // Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      width: 375,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(group.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Description
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      height: 120,
                      width: 375,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          Text(group.description,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Events
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      height: 120,
                      width: 375,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Upcoming Events:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26)),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(group.upcomingEvents,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Join / Request Invite Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 55,
                  width: 375,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(38, 95, 70, 1.0),
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if(!groupDB.getMembers(groupID).contains(currentUserID)){
                        groupDB.addMember(currentUserID, groupID);
                        userDB.addGroup(currentUserID, groupID);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("You're already in this group!"),
                          duration: Duration(seconds: 5),
                        ));
                      }
                    },
                    child: const Text('Join / Request Invite',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
