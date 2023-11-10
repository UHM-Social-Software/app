import 'package:app/features/group/domain/groups_collection.dart';
import 'package:app/features/user/domain/user_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../global_snackbar.dart';
import '../../user/presentation/edit_user_controller.dart';
import '../domain/group.dart';
import '../../user/domain/user.dart';
import 'edit_group_controller.dart';

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
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          currentUserID: allData.currentUserID,
          users: allData.users,
          groups: allData.groups,
          ref: ref,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
        required List<User> users,
        required String currentUserID, required List<Group> groups, required WidgetRef ref}) {
    final groupCollection = GroupCollection(groups);
    final userCollection = UserCollection(users);
    Group group = groupCollection.getGroup(groupID);

    void joinGroup(){
      List<String> newMembership = [];
      for (var member in group.membership){
        newMembership.add(member);
      }
      newMembership.add(currentUserID);
      Group updatedGroup = Group(
        id: groupID,
        name: group.name,
        description: group.description,
        upcomingEvents: group.name,
        imagePath: group.imagePath,
        owner: group.owner,
        membership: newMembership,
      );
      ref.read(editGroupControllerProvider.notifier).updateGroup(
        group: updatedGroup,
        onSuccess: () {
        },
      );
      User user = userCollection.getUser(currentUserID);
      List<String> newUserGroups = [];
      for (var group in user.groups){
        newUserGroups.add(group);
      }
      newUserGroups.add(groupID);
      User updatedUser = User(
        id: currentUserID,
        name: user.name,
        bio: user.bio,
        classes: user.classes,
        imagePath: user.imagePath,
        interests: user.interests,
        email: user.email,
        groups: newUserGroups,
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: updatedUser,
        onSuccess: () {
          GlobalSnackBar.show('Group joined!');
        },
      );
    }

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
                      image: group.imagePath.toString() == "assets/images/default_profile.png" ? AssetImage(group.imagePath.toString()) : NetworkImage(group.imagePath.toString()) as ImageProvider,
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
                      if(!groupCollection.getMembers(groupID).contains(currentUserID)){
                        joinGroup();
                        // Navigator.pop(context);
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
