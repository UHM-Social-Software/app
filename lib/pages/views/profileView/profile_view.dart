import 'package:flutter/material.dart';

import 'components/classes_view.dart';
import 'components/groups_view.dart';

/// Top-level Layout for all of the "Home" related
class ProfileView extends StatefulWidget {
  ProfileView({
    super.key,
  });

  static const routeName = '/ProfileView';

  // This data structure will eventually become stateful and thus will
  // need to be moved into the state widget.
  final Map pages = {
    0: {
      'title': const Text('Classes'),
      'body': const ClassesView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Classes',
        icon: Icon(Icons.person_outline_rounded),
      ),
    },
    1: {
      'title': const Text('Groups'),
      'body': const GroupsView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Groups',
        icon: Icon(Icons.search_rounded),
      ),
    },
  };

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/default_profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 175,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text('Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(width: 25.0),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 175,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          // open messages
                        },
                        child: Text('Message',
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
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      height: 60,
                      width: 375,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                          'This is a sample Bio. There will be a feature for each user to edit their own bio.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      height: 60,
                      width: 375,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text('Interests will be displayed here.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 175,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (0 != _selectedIndex) {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          }
                        },
                        child: Text('Classes',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 25.0),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 175,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (1 != _selectedIndex) {
                            setState(() {
                              _selectedIndex = 1;
                            });
                          }
                        },
                        child: Text('Groups',
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
            Container(
              height: 200,
              alignment: Alignment.center,
              child: widget.pages[_selectedIndex]['body'],
            ),
          ],
        ),
      ),
    );
  }
}
