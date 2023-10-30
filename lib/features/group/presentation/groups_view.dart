import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
import 'view_group_bar.dart';

/// Displays a list of groups for which the currently signed in user is a member
class GroupsView extends ConsumerWidget {
  const GroupsView({
    super.key,
  });

  final String title = 'groupsView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          currentUserID: allData.currentUserID,
          users: allData.users,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
        required String currentUserID,
        required List<User> users}) {
    final userCollection = UserCollection(users);
    List<String> groupIDs = userCollection.getUserGroups(currentUserID);

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
