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

/// Displays a list of interests and options to add/delete them for the currently signed in user.
class EditInterests extends ConsumerWidget {
  EditInterests({
    super.key,
  });

  final _interestsFormKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            users: allData.users,
          ref: ref),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users, required WidgetRef ref,
  }) {
    final userCollection = UserCollection(users);
    final user = FirebaseAuth.instance.currentUser;
    final currentUserID = user!.uid;
    User currentUser = userCollection.getUser(currentUserID);
    List<String>? interests = userCollection.getUser(currentUserID).interests;

    void addInterest(){
      List<String> updatedInterests = [];
      if (currentUser.interests != Null){
        for (var interest in currentUser.interests!){
          updatedInterests.add(interest);
        }
      }
      updatedInterests.add(_interestsFormKey.currentState?.value);
      User updatedUser = User(
        id: currentUserID,
        name: currentUser.name,
        interests: updatedInterests,
        groups: currentUser.groups,
        email: currentUser.email,
        classes: currentUser.classes,
        imagePath: currentUser.imagePath,
        bio: currentUser.bio,
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: updatedUser,
        onSuccess: () {
        },
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Display Interests
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    ...?interests?.map((interest) => _InterestBar(interestName: interest, userCollection: userCollection, currentUserID: currentUserID))
                  ],
                ),
              ),
            ],
          ),
          // Add Interests Form
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 45,
                            width: 375,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(38, 95, 70, 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: FormBuilderTextField(
                              style: TextStyle(color: Colors.white),
                              key: _interestsFormKey,
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
                                hintText: "New interest",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                                addInterest();
                                // Navigator.pushReplacementNamed(context, HomeView.routeName);
                              },
                              child: const Text('Add',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold, fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// Displays an interest given its name, shows option to delete from currentUser interests
class _InterestBar extends ConsumerWidget {

  const _InterestBar({
    required this.interestName, required this.userCollection, required this.currentUserID
  });

  final String interestName;
  final UserCollection userCollection;
  final String currentUserID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    User currentUser = userCollection.getUser(currentUserID);

    void deleteInterest(String interestName){
      List<String> updatedInterests = [];
      for (var interest in currentUser.interests!){
        if(interest != interestName){
          updatedInterests.add(interest);
        }
      }
      User updatedUser = User(
        id: currentUserID,
        name: currentUser.name,
        interests: updatedInterests,
        groups: currentUser.groups,
        email: currentUser.email,
        classes: currentUser.classes,
        imagePath: currentUser.imagePath,
        bio: currentUser.bio,
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: updatedUser,
        onSuccess: () {
        },
      );
      //Navigator.pushReplacementNamed(context, HomeView.routeName);
    }

    return Column(
      children: [
        Container(
          height: 45,
          width: 375,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(38, 95, 70, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 15),
              Container(
                alignment: Alignment.centerLeft,
                height: 45,
                child: Text(interestName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
              ),
              const SizedBox(width: 20),
              Container(
                alignment: Alignment.centerRight,
                height: 45,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    deleteInterest(interestName);
                  },
                  child: const Icon(color: Colors.white, Icons.delete_forever_outlined),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}