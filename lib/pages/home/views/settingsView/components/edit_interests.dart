import 'package:app/pages/home/views/settingsView/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data_model/user_db.dart';
import '../../../home_view.dart';

/// Displays a news item given its ID.
class EditInterests extends ConsumerWidget {
  EditInterests({
    super.key,
  });

  final _interestsFormKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    List<String>? interests = userDB.getUser(currentUserID).interests;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ...?interests?.map((interest) => _InterestBar(interestName: interest))
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 45,
                        width: 375,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(38, 95, 70, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: FormBuilderTextField(
                          key: _interestsFormKey,
                          name: 'bio',
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(38, 95, 70, 1.0),
                            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                            hintText: "Add interest",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 375,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(38, 95, 70, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            String newInterest = _interestsFormKey.currentState?.value;
                            userDB.addUserInterest(currentUserID, newInterest);
                            Navigator.pushReplacementNamed(context, HomeView.routeName);
                          },
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _InterestBar extends ConsumerWidget {
  const _InterestBar({
    super.key,
    required this.interestName,
  });

  final String interestName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void deleteInterest(String interestName){
      final UserDB userDB = ref.watch(userDBProvider);
      final String currentUserID = ref.watch(currentUserIDProvider);
      userDB.removeUserInterest(currentUserID, interestName);
      Navigator.pushReplacementNamed(context, HomeView.routeName);
    }

    return Column(
      children: [
        Container(
          height: 45,
          width: 375,
          decoration: BoxDecoration(
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
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
              ),
              const SizedBox(width: 20),
              Container(
                alignment: Alignment.centerRight,
                height: 45,
                decoration: BoxDecoration(
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