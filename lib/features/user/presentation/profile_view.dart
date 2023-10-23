import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/user_providers.dart';
import '../domain/user_db.dart';
import '../../class/presentation/classes_view.dart';
import '../../group/presentation/groups_view.dart';


/// Middle-level Layout for the profile view, shows either classes or groups for currently signin user
class ProfileView extends ConsumerStatefulWidget {
  ProfileView({
    super.key,
  });

  static const routeName = '/ProfileView';

  // This data structure will eventually become stateful and thus will
  // need to be moved into the state widget.
  final Map pages = {
    0: {
      'body': const ClassesView(),
    },
    1: {
      'body': const GroupsView(),
    },
  };

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final UserDB userDB = ref.watch(userDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    UserData user = userDB.getUser(currentUserID);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12.0),
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
                      image: AssetImage(
                          user.imagePath != null ? user.imagePath.toString() : 'assets/images/default_profile.png'
                      ),
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
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(user.name,
                          style: const TextStyle(
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
                        color: const Color.fromRGBO(38, 95, 70, 1.0),
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          // open messages
                        },
                        child: const Text('Message',
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
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      height: 60,
                      width: 375,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                          user.bio != null ? user.bio.toString() : '',
                          style: const TextStyle(
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
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      height: 60,
                      width: 375,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(user.interests != null ? user.interests.toString() : '',
                          style: const TextStyle(
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
                      decoration: const BoxDecoration(
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
                        child: const Text('Classes',
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
                      decoration: const BoxDecoration(
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
                        child: const Text('Groups',
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
            const SizedBox(height: 10),
            Container(
              height: 292,
              alignment: Alignment.center,
              child: widget.pages[_selectedIndex]['body'],
            ),
          ],
        ),
      ),
    );
  }
}