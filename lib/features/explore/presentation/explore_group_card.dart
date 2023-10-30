import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../group/domain/group.dart';
import '../../group/domain/groups_collection.dart';
import '../../group/presentation/view_group_page.dart';

/// Displays a group item given its ID in the explore page format.
class ExploreGroupCard extends ConsumerWidget {
  const ExploreGroupCard({
    super.key,
    required this.groupID,
  });

  final String groupID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          groups: allData.groups,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
        required List<Group> groups}) {
    final groupCollection = GroupCollection(groups);

    return Container(
      height: 180,
      width: 180,
      margin: const EdgeInsets.all(5),
      child: Card(
        color: const Color.fromRGBO(38, 95, 70, 1.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupPage(
                    groupID: groupID,
                      )),
            );
          },
          child: Text(groupCollection.getGroup(groupID).name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
