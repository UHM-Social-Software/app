import 'package:app/features/user/domain/user_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../course/presentation/classes_viewer_page.dart';
import '../../group/presentation/groups_viewer_page.dart';
import '../domain/user.dart';


/// Middle-level Layout for the profile viewer, shows either classes or groups for the given userID
class ProfileViewerPage extends ConsumerStatefulWidget {
  ProfileViewerPage({
    super.key,
    required this.studentID,
  });

  late Map pages = {
    0: {
      'body': ClassesViewerPage(studentID: studentID),
    },
    1: {
      'body': GroupsViewerPage(studentID: studentID),
    },
  };

  static const routeName = '/ProfileViewerPage';
  final String studentID;


  @override
  ConsumerState<ProfileViewerPage> createState() => _ProfileViewerPageState(studentID);
}

class _ProfileViewerPageState extends ConsumerState<ProfileViewerPage> {
  _ProfileViewerPageState(this.studentID);
  final String studentID;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            users: allData.users),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
  }) {
    final userCollection = UserCollection(users);
    User user = userCollection.getUser(studentID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
        title: const Text(''),
      ),
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