import 'package:flutter/material.dart';

import '../pages/chapters/chapters_view.dart';
import '../pages/discussions/discussions_view.dart';
import '../pages/gardens/gardens_view.dart';
import '../pages/help/help_view.dart';
import '../pages/home/home_view.dart';
import '../pages/members/members_view.dart';
import '../pages/outcomes/outcomes_view.dart';
import '../pages/seeds/seeds_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Jenna Deane"),
            accountEmail: const Text("jennacorindeane@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/jenna-deane.jpg'),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.yard_outlined),
            title: const Text('Gardens'),
            onTap: () {
              Navigator.pushReplacementNamed(context, GardensView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text('Chapters'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ChaptersView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.trending_up),
            title: const Text('Outcomes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OutcomesView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            title: const Text('Seeds'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SeedsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Members'),
            onTap: () {
              Navigator.pushReplacementNamed(context, MembersView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Discussions'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, DiscussionsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HelpView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'bad page');
            },
          ),
        ],
      ),
    );
  }
}
