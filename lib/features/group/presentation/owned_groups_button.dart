import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'owned_groups.dart';

/// Displays a button linked to see all owned groups
class MyGroupsButton extends ConsumerWidget {
  const MyGroupsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
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
                  MaterialPageRoute(builder: (context) => const MyGroups()),
                );
              },
              child: const Text('My Groups',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
        ),
      ],
    );
  }
}
