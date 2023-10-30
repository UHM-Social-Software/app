import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../domain/group.dart';
import '../domain/groups_collection.dart';
import 'view_group_page.dart';

/// Displays a group bar linked to its viewing page given a group ID.
class GroupBar extends ConsumerWidget {
  const GroupBar({
    super.key,
    required this.groupID,
  });

  final String groupID;

  @override
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
    Group group = groupCollection.getGroup(groupID);

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 45,
          width: 375,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(38, 95, 70, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
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
            child: Text(group.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
