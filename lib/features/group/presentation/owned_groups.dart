import 'package:app/features/group/domain/groups_collection.dart';
import 'package:app/features/group/presentation/edit_group_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../domain/group.dart';
import '../../user/domain/user.dart';

/// Displays a list of groups for which the currently signed in user is the owner
class MyGroups extends ConsumerWidget {
  const MyGroups({
    super.key,
  });

  static const routeName = '/my_groups';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
              context: context,
              groups: allData.groups,
              currentUserID: allData.currentUserID,
              users: allData.users,
            ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
      required List<Group> groups,
      required String currentUserID,
      required List<User> users}) {
    final groupCollection = GroupCollection(groups);

    List<String> groupIDs =
        groupCollection.getMyGroupIDs(currentUserID);
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
                        ...groupIDs
                            .map((groupID) => EditGroupBar(groupID: groupID)),
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
