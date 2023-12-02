import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
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
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          users: allData.users,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
        required List<User> users}) {
    final userCollection = UserCollection(users);
    List<String> groupIDs = userCollection.getUserGroups(studentID);

    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                children: [
                  ...groupIDs.map((groupID) => GroupBar(groupID: groupID)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
