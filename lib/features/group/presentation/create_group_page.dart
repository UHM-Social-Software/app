import 'package:app/features/group/domain/group_db.dart';
import 'package:app/features/user/domain/user_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/data/user_providers.dart';
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
    final GroupDB groupDB = ref.watch(groupDBProvider);
    final UserDB userDB = ref.watch(userDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);

    void createPressed() {
      groupDB.createGroup(
          name: _nameFieldKey.currentState?.value,
          description: _descriptionFieldKey.currentState?.value,
          upcomingEvents: _eventsFieldKey.currentState?.value,
          ownerID: currentUserID);
      userDB.getUser(currentUserID).groups = groupDB.getMyGroupIDs(currentUserID);
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
                          onPressed: () {
                            //not implemented yet
                          },
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
