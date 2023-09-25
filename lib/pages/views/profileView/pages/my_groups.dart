import 'package:flutter/material.dart';

import 'edit_group.dart';

/// Displays a list of Gardens.
class MyGroups extends StatelessWidget {
  MyGroups({
    super.key,
  });

  static const routeName = '/my_groups';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 95, 70, 1.0),
        title: Text('My Groups'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Tap To Edit:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  const SizedBox(width: 230),
                ],
              ),
              const SizedBox(height: 10.0),
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
                            title: 'Cooler Chess Club',
                          )),
                    );
                  },
                  child: Text('Cooler Chess Club',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
