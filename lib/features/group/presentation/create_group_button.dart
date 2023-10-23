import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_group_page.dart';

/// Displays a button to create a group.
class CreateGroupButton extends ConsumerWidget {
  const CreateGroupButton({
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
            color: const Color.fromRGBO(38, 95, 70, 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateGroup()),
              );
            },
            child: const Text('Create Group',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
