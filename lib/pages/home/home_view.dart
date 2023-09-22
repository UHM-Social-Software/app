import 'package:flutter/material.dart';

import 'views/explore_view.dart';
import 'views/messages_view.dart';
import 'views/profileView/profile_view.dart';

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
      'body': ProfileView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Profile',
        icon: Icon(Icons.person_outline_rounded),
      ),
    },
    1: {
      'title': const Text('Explore'),
      'body': const ExploreView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Explore',
        icon: Icon(Icons.search_rounded),
      ),
    },
    2: {
      'title': const Text('Messages'),
      'body': const MessagesView(),
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
      body: SafeArea(
        minimum: EdgeInsets.all(12.0),
        child: widget.pages[_selectedIndex]['body'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed when more than 3 items
        backgroundColor: Colors.black, // <-- This works for fixed
        selectedItemColor: Color.fromRGBO(81, 202, 149, 1.0),
        unselectedItemColor: Colors.grey,
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
