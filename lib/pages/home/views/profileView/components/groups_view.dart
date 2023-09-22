import 'package:flutter/material.dart';

import '../../../../../pages/sample_feature/sample_item.dart';

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
      body: Text("Groups View"),
    );
  }
}
