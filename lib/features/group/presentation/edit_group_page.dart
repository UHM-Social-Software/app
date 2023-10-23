import 'package:app/features/home/presentation/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/group_providers.dart';
import '../domain/group_db.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user_db.dart';

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
    final GroupDB groupDB = ref.watch(groupDBProvider);
    GroupData group = groupDB.getGroup(groupID);
    List<String> memberIDs = groupDB.getMembers(groupID);

    final UserDB userDB = ref.watch(userDBProvider);
    List<String> memberNames = userDB.getUserNames(memberIDs);

    void savePressed() {
      // update groupDB
      groupDB.updateGroup(
          groupID,
          _descriptionFieldKey.currentState?.value ?? group.description,
          _eventsFieldKey.currentState?.value ?? group.upcomingEvents
      );
      Navigator.pushReplacementNamed(context, HomeView.routeName);
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
                        onPressed: () {
                          // not implemented yet
                        },
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
                          hintText: 'Enter New Club Description',
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
                          hintText: 'Change Upcoming Events',
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
                                  ...memberNames.map((name) => _MemberBar(name: name, groupID: groupID))
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
  const _MemberBar({
    required this.name,
    required this.groupID,
  });

  final String name;
  final String groupID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final UserDB userDB = ref.watch(userDBProvider);

    void removeMember(String name){
      final GroupDB groupDB = ref.watch(groupDBProvider);
      userDB.removeGroup(userDB.getUserIDWithName(name), groupID);
      groupDB.removeMember(userDB.getUserIDWithName(name), groupID);
      Navigator.pop(context);
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
                    if(currentUserID == userDB.getUserIDWithName(name)){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text("Cannot Remove Owner"),
                        duration: Duration(seconds: 5),
                      ));
                    }else{
                      removeMember(name);
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
