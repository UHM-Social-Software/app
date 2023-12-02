import 'package:app/features/user/domain/user_collection.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../global_snackbar.dart';
import '../domain/user.dart';
import '../../home/presentation/home_view.dart';
import 'edit_user_controller.dart';

/// Displays a form to edit the currently logged in user's bio.
class EditBioForm extends ConsumerWidget {
  EditBioForm({
    super.key,
  });

  final _bioFormKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            users: allData.users,
          ref: ref,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users, required WidgetRef ref,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    final currentUserID = user!.uid;
    final userCollection = UserCollection(users);
    User currentUser = userCollection.getUser(currentUserID);

    void updateBio(){
      String newBio = _bioFormKey.currentState?.value;
      User updatedUser = User(
        id: currentUserID,
        name: currentUser.name,
        interests: currentUser.interests,
        groups: currentUser.groups,
        email: currentUser.email,
        classes: currentUser.classes,
        imagePath: currentUser.imagePath,
        bio: newBio,
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: updatedUser,
        onSuccess: () {
          GlobalSnackBar.show('Updated Bio!');
        },
      );
    }

    return Column(
      children: [
        // Edit Bio Form
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
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
                    hintText: userCollection.getBio(currentUserID),
                  ),
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
            Flexible(
              child: Container(
                alignment: Alignment.center,
                height: 45,
                width: 375,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    updateBio();
                    // Navigator.pushReplacementNamed(context, HomeView.routeName);
                  },
                  child: const Text('Save New Bio',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
