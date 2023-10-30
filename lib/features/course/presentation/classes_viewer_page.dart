import 'package:app/features/course/presentation/class_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';

/// Displays a list of classes that the given studentID is in.
class ClassesViewerPage extends ConsumerWidget {
  const ClassesViewerPage({
    super.key,
    required this.studentID,
  });

  final String title = 'ClassesViewerPage';
  final String studentID;

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
    User user = userCollection.getUser(studentID);
    List<String> classNames = user.classes;

    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ...classNames.map((className) => ClassBar(className: className))
              ],
            ),
          ],
        ),
      ),
    );
  }
}