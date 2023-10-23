import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_providers.dart';
import '../domain/user_db.dart';
import '../../home/presentation/home_view.dart';

/// Displays a form to edit the currently logged in user's bio.
class EditBioForm extends ConsumerWidget {
  EditBioForm({
    super.key,
  });

  final _bioFormKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);

    return Column(
      children: [
        // Edit Bio Form
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: 100,
              width: 375,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(38, 95, 70, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: FormBuilderTextField(
                key: _bioFormKey,
                maxLines: 3,
                minLines: 2,
                name: 'bio',
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(38, 95, 70, 1.0),
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                  hintText: userDB.getBio(currentUserID),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        // Save New Bio Button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 45,
              width: 375,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(38, 95, 70, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: MaterialButton(
                onPressed: () {
                  String newBio = _bioFormKey.currentState?.value;
                  userDB.updateUserBio(currentUserID, newBio);
                  Navigator.pushReplacementNamed(context, HomeView.routeName);
                },
                child: const Text('Save New Bio',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}