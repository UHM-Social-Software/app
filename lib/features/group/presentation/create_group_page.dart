import 'dart:typed_data';

import 'package:app/features/group/domain/group.dart';
import 'package:app/features/group/domain/groups_collection.dart';
import 'package:app/features/user/domain/user.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../../repositories/add_data.dart';
import '../../../utils.dart';
import '../../all_data_provider.dart';
import '../../global_snackbar.dart';
import '../../user/domain/user_collection.dart';
import '../../user/presentation/edit_user_controller.dart';
import '../data/group_database.dart';
import '../data/group_providers.dart';
import 'owned_groups.dart';

/// Displays a form for creating a group.
class CreateGroup extends ConsumerWidget {
  CreateGroup({
    super.key,
  });

  static const routeName = '/createGroupView';

  final _formKey = GlobalKey<FormBuilderState>();
  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _descriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final _eventsFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          groups: allData.groups,
          users: allData.users,
          ref: ref,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
        required List<Group> groups, required List<User> users, required WidgetRef ref}) {
    final groupCollection = GroupCollection(groups);
    final userCollection = UserCollection(users);
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserID = currentUser!.uid;

    void addGroupToCurrentUserGroups(Group group){
      List<String> updatedGroups = [];
      User currentUser = userCollection.getUser(currentUserID);
        for (var groupID in currentUser.groups){
          updatedGroups.add(groupID);
        }
      updatedGroups.add(group.id);
      User updatedUser = User(
        id: currentUserID,
        name: currentUser.name,
        interests: currentUser.interests,
        groups: updatedGroups,
        email: currentUser.email,
        classes: currentUser.classes,
        imagePath: currentUser.imagePath,
        bio: currentUser.bio,
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: updatedUser,
        onSuccess: () {
          GlobalSnackBar.show('Added Group!');
        },
      );
    }

    Uint8List? _image;

    void selectImage() async {
      _image = await pickImage(ImageSource.gallery);
    }

    Future<void> createPressed() async {
      int numGroups = groupCollection.size();
      String id = 'group-${(numGroups + 1).toString().padLeft(3, '0')}';
      Group group = Group(
          imagePath: "assets/images/default_profile.png",
          name: _nameFieldKey.currentState?.value,
          description: _descriptionFieldKey.currentState?.value,
          upcomingEvents: _eventsFieldKey.currentState?.value,
          owner: currentUserID, id: id, membership: [currentUserID],
      );
      GroupDatabase groupDatabase = ref.watch(groupDatabaseProvider);
      groupDatabase.setGroup(group);
      addGroupToCurrentUserGroups(group);
      String resp = await StoreData().saveGroupImage(file: _image!, group: group, ref: ref);
      Navigator.pushReplacementNamed(context, MyGroups.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
        backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
      ),
      body: Column(
        children: [
          FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  // Enter Club Name
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
                        child: FormBuilderTextField(
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                              fontSize: 20),
                          key: _nameFieldKey,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(38, 95, 70, 1.0),
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            hintText: 'Enter Club Name',
                          ),
                          name: 'name',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  // Upload Club Image
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
                          onPressed: selectImage,
                          child: const Text('Upload Club/Group Image',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  // Enter Club Description
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 20),
                          key: _descriptionFieldKey,
                          maxLines: 3,
                          minLines: 2,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(38, 95, 70, 1.0),
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 20),
                            hintText: 'Enter Club Description',
                          ),
                          name: 'description',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  // Enter Upcoming Events
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 20),
                          key: _eventsFieldKey,
                          maxLines: 3,
                          minLines: 2,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(38, 95, 70, 1.0),
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 20),
                            hintText: 'Enter Upcoming Events List',
                          ),
                          name: 'events',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              )),
          // Create Button
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
                    createPressed();
                  },
                  child: const Text('Create',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
