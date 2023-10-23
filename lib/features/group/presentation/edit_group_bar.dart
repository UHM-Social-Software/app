import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/group_providers.dart';
import '../domain/group_db.dart';
import 'edit_group_page.dart';

/// Displays a group bar linked to its edit page given a group ID.
class EditGroupBar extends ConsumerWidget {
  const EditGroupBar({
    super.key,
    required this.groupID,
  });

  final String groupID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupDB groupDB = ref.watch(groupDBProvider);
    GroupData group = groupDB.getGroup(groupID);

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
                    builder: (context) => EditGroup(
                      groupID: group.id,
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
