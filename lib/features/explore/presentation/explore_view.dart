import 'package:app/features/explore/presentation/explore_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../group/data/group_providers.dart';
import '../../group/domain/group_db.dart';

/// Displays a list of groups in the database.
class ExploreView extends ConsumerWidget {
  const ExploreView({
    super.key,
  });

  static const routeName = '/ExploreView';
  final String title = 'ExploreView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupDB groupDB = ref.watch(groupDBProvider);
    List<String> groupIDs = groupDB.getGroupIDs();
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
