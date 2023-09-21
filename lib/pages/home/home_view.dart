import 'package:flutter/material.dart';

import '../../components/drawer_view.dart';
import '../../pages/home/bodies/news_body_view.dart';
import '../settings/settings_view.dart';
import 'bodies/gardens_body_view.dart';

/// Top-level Layout for all of the "Home" related
class HomeView extends StatefulWidget {
  HomeView({
    super.key,
  });

  static const routeName = '/home';

  // This data structure will eventually become stateful and thus will
  // need to be moved into the state widget.
  final Map pages = {
    0: {
      'title': const Text('Profile'),
      'body': const NewsBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Profile',
        icon: Icon(Icons.person_outline_rounded),
      ),
    },
    1: {
      'title': const Text('Explore'),
      'body': const GardensBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Explore',
        icon: Icon(Icons.search_rounded),
      ),
    },
    2: {
      'title': const Text('Messages'),
      'body': const GardensBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Messages',
        icon: Icon(Icons.message_outlined),
      ),
    },
  };

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: widget.pages[_selectedIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: [
          widget.pages[0]['navItem'],
          widget.pages[1]['navItem'],
          widget.pages[2]['navItem'],
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
