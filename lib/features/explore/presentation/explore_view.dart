import 'package:app/features/explore/presentation/explore_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../group/domain/group.dart';
import '../../group/domain/groups_collection.dart';

/// Displays a list of groups in the database.
class ExploreView extends ConsumerWidget {
  const ExploreView({
    super.key,
  });

  static const routeName = '/ExploreView';
  final String title = 'ExploreView';

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
    List<String> groupIDs = groupCollection.getGroupIDs();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
            ),
            filled: false,
            fillColor: const Color.fromRGBO(38, 95, 70, .6),
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: 'Search',
          ),
        ),
        backgroundColor: const Color.fromRGBO(38, 95, 70, .6),
        toolbarHeight: 60.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          ...groupIDs.map((groupID) => ExploreGroupCard(groupID: groupID))
        ],
      ),
    );
  }
}
