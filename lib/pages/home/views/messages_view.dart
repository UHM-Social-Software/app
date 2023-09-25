import 'package:flutter/material.dart';


/// Displays a list of Gardens.
class MessagesView extends StatelessWidget {
  const MessagesView({
    super.key,
  });

  static const routeName = '/messages';
  final String title = 'messages';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Messages Page"),
    );
  }
}
