import 'package:app/features/user/domain/user_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../domain/user.dart';
import '../../home/presentation/home_view.dart';

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
            currentUserID: allData.currentUserID,
            users: allData.users),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required String currentUserID,
    required List<User> users,
  }) {
    final userCollection = UserCollection(users);
    User activeUser = userCollection.getUser(currentUserID);

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
                  hintText: userCollection.getBio(currentUserID),
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
                  activeUser = activeUser.copyWith(bio: newBio);
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
