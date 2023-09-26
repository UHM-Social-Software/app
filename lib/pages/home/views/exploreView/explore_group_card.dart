import 'package:app/data_model/user_db.dart';
import 'package:flutter/material.dart';

import '../profileView/pages/group_page.dart';

/// Displays a news item given its ID.
class ExploreGroupCard extends StatelessWidget {
  const ExploreGroupCard({
    super.key,
    required this.groupName,
  });

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      margin: EdgeInsets.all(5),
      child: Card(
        color: Color.fromRGBO(38, 95, 70, 1.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupPage(
                        groupName: groupName,
                      )),
            );
          },
          child: Text(groupName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
