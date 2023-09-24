import 'package:flutter/material.dart';

import '../../../../../pages/sample_feature/sample_item.dart';
import '../pages/class_page.dart';
import '../pages/group_page.dart';

/// Displays a list of Gardens.
class GroupsView extends StatelessWidget {
  const GroupsView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  static const routeName = '/messages';
  final List<SampleItem> items;
  final String title = 'messages';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 10.0),
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
                          builder: (context) => GroupPage(
                                title: 'Cooler Chess Club',
                              )),
                    );
                  },
                  child: Text('Cooler Chess Club',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
