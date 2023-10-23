import 'package:app/features/class/presentation/class_bar.dart';
import 'package:app/features/user/domain/user_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/data/user_providers.dart';

/// Displays a list of classes that the current user is in.
class ClassesView extends ConsumerWidget {
  const ClassesView({
    super.key,
  });

  final String title = 'classesView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final UserDB userDB = ref.watch(userDBProvider);
    UserData user = userDB.getUser(currentUserID);
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