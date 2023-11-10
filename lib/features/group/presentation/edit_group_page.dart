import 'dart:typed_data';

import 'package:app/features/home/presentation/home_view.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../../repositories/add_data.dart';
import '../../all_data_provider.dart';
import '../../global_snackbar.dart';
import '../../user/domain/user_collection.dart';
import '../../user/presentation/edit_user_controller.dart';
import '../domain/group.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../domain/groups_collection.dart';
import 'edit_group_controller.dart';
import 'package:app/utils.dart';

/// Displays a form for editing an existing group.
class EditGroup extends ConsumerWidget {
  EditGroup({
    super.key,
    required this.groupID,
  });

  static const routeName = '/editGroupView';
  final String groupID;

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
          currentUserID: allData.currentUserID,
          ref: ref,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
        required List<Group> groups,
        required List<User> users, required String currentUserID, required WidgetRef ref}
  ) {
    final userCollection = UserCollection(users);
    final groupCollection = GroupCollection(groups);
    Group group = groupCollection.getGroup(groupID);
    List<String> memberIDs = groupCollection.getMembers(groupID);
    List<String> memberNames = userCollection.getUserNames(memberIDs);

    Uint8List? _image;


    void selectImage() async {
      _image = await pickImage(ImageSource.gallery);
      String resp = await StoreData().saveGroupImage(file: _image!, group: group, ref: ref);
    }

    void savePressed() {
      String newDescription = _descriptionFieldKey.currentState?.value ?? group.description;
      String newEvents = _eventsFieldKey.currentState?.value ?? group.upcomingEvents;
      Group updatedGroup = Group(
        id: group.id,
        name: group.name,
        description: newDescription,
        upcomingEvents: newEvents,
        imagePath: group.imagePath,
        owner: group.owner,
        membership: group.membership,
      );
      ref.read(editGroupControllerProvider.notifier).updateGroup(
        group: updatedGroup,
        onSuccess: () {
          GlobalSnackBar.show('Group Updated!');
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Editing: ${group.name}'),
        backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
      ),
      body: Column(
        children: [
          FormBuilder(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                // Upload Image
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
                        child: const Text('Upload New Club/Group Image',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Enter New Club Description
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
                        key: _descriptionFieldKey,
                        maxLines: 3,
                        minLines: 2,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                            const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                            const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(38, 95, 70, 1.0),
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 20),
                          hintText: 'Enter New Description. Current: ${group.description}',
                        ),
                        name: 'description',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Enter New Events
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
                        key: _eventsFieldKey,
                        maxLines: 3,
                        minLines: 2,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                            const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                            const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(38, 95, 70, 1.0),
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 20),
                          hintText: 'Change Upcoming Events. Current: ${group.upcomingEvents}',
                        ),
                        name: 'events',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          // Save Edits button
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
                    savePressed();
                    // Navigator.pushReplacementNamed(context, HomeView.routeName);
                  },
                  child: const Text('Save Edits',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 43.0),
          // Member List
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    height: 250,
                    width: 375,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(38, 95, 70, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Member List:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26)),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  ...memberNames.map((name) => _MemberBar(name: name, groupID: groupID, userCollection: userCollection, groupCollection: groupCollection, currentUserID: currentUserID))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/// Displays a delete bar for a given group member name and groupID.
class _MemberBar extends ConsumerWidget {
  _MemberBar({
    required this.name,
    required this.groupID, required this.userCollection, required  this.groupCollection, required this.currentUserID,
  });

  final String name;
  final String groupID;
  UserCollection userCollection;
  GroupCollection groupCollection;
  final String currentUserID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Group group = groupCollection.getGroup(groupID);

    final String currentUserID = ref.watch(currentUserIDProvider);

    void removeGroupIDFromUserGroups(){
      List<String> updatedGroups = [];
      String userIDToRemove = userCollection.getUserIDWithName(name);
      User userToRemove = userCollection.getUser(userIDToRemove);
      for (var nextGroupID in userToRemove.groups){
        if(nextGroupID != groupID){
          updatedGroups.add(groupID);
        }
      }
      User updatedUser = User(
        id: userIDToRemove,
        name: userToRemove.name,
        interests: userToRemove.interests,
        groups: updatedGroups,
        email: userToRemove.email,
        classes: userToRemove.classes,
        imagePath: userToRemove.imagePath,
        bio: userToRemove.bio,
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: updatedUser,
        onSuccess: () {
          GlobalSnackBar.show('Added Group!');
        },
      );
    }

    void removeMemberFromGroup(String name) {
      removeGroupIDFromUserGroups();

      List<String> updatedMembership = [];
      String userIDToRemove = userCollection.getUserIDWithName(name);

      for (var nextUserID in group.membership){
        if(nextUserID != userIDToRemove){
          updatedMembership.add(nextUserID);
        }
      }
      Group updatedGroup = Group(
        imagePath: "assets/images/default_profile.png",
        name: group.name,
        description: group.description,
        upcomingEvents: group.upcomingEvents,
        owner: currentUserID,
        id: groupID,
        membership: updatedMembership,
      );
      ref.read(editGroupControllerProvider.notifier).updateGroup(
        group: updatedGroup,
        onSuccess: () {
          GlobalSnackBar.show('Added Group!');
        },
      );
    }

    return Column(
      children: [
        Container(
          height: 45,
          width: 355,
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
                child: Text(name,
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
                    if(currentUserID == userCollection.getUserIDWithName(name)){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text("Cannot Remove Owner"),
                        duration: Duration(seconds: 5),
                      ));
                    }else{
                      removeMemberFromGroup(name);
                    }
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
