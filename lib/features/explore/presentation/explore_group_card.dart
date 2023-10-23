import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../group/data/group_providers.dart';
import '../../group/domain/group_db.dart';
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
    final GroupDB groupDB = ref.watch(groupDBProvider);
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
          child: Text(groupDB.getGroup(groupID).name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
