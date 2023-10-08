import 'package:app/data_model/user_db.dart';
import 'package:flutter/material.dart';


import '../../../../../data_model/group_db.dart';
import 'edit_group.dart';

/// Displays a news item given its ID.
class EditGroupBar extends StatelessWidget {
  const EditGroupBar({
    super.key,
    required this.groupID,
  });

  final String groupID;

  @override
  Widget build(BuildContext context) {
    GroupData group = groupDB.getGroup(groupID);

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 45,
          width: 375,
          decoration: BoxDecoration(
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
                style: TextStyle(
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
