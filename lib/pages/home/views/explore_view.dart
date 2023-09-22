import 'package:flutter/material.dart';

import '../../../../../pages/sample_feature/sample_item.dart';

/// Displays a list of Gardens.
class ExploreView extends StatelessWidget {
  const ExploreView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  static const routeName = '/explore';
  final List<SampleItem> items;
  final String title = 'explore';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Explore Page"),
    );
  }
}
