import 'package:app/features/course/presentation/class_bar.dart';
import 'package:app/features/user/domain/user.dart';
import 'package:app/features/user/domain/user_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';

/// Displays a list of classes that the current user is in.
class ClassesView extends ConsumerWidget {
  const ClassesView({
    super.key,
  });

  final String title = 'classesView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          users: allData.users,
          currentUserID: allData.currentUserID,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context, required String currentUserID, required List<User> users}) {
    final userCollection = UserCollection(users);
    User user = userCollection.getUser(currentUserID);
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