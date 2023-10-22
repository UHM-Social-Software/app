import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/create_group.dart';
import '../pages/my_groups.dart';

/// Displays a news item given its ID.
class MyGroupsButton extends ConsumerWidget {
  const MyGroupsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 45,
          width: 375,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Color.fromRGBO(38, 95, 70, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyGroups()),
              );
            },
            child: Text('My Groups',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
