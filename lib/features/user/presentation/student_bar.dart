import 'package:app/features/user/domain/user.dart';
import 'package:app/features/user/domain/user_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import 'profile_viewer_page.dart';

/// Displays basic user info in a bar given a UserID
class StudentBar extends ConsumerWidget {
  const StudentBar({
    super.key,
    required this.userID,
  });

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
              context: context,
              users: allData.users,
            ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
      required List<User> users}) {
    final userCollection = UserCollection(users);
    final User student = userCollection.getUser(userID);

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 375,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(38, 95, 70, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: MaterialButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileViewerPage(
                        studentID: userID,
                      )),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 15.0),
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(student.imagePath.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Text(student.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    const SizedBox(width: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
