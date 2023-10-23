import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../user/data/user_providers.dart';
import '../../user/domain/user_db.dart';

/// Presents the page containing fields to enter a username and password, plus buttons.
class SigninView extends ConsumerWidget {
  SigninView({Key? key}) : super(key: key);

  static const routeName = '/';

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            const Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  "Welcome to ''Meet Your People''",
                  textScaleFactor: 2,
                  style: TextStyle(fontFamily: 'Chancery'),
                ),
              ],
            ),
            const SizedBox(height: 200.0),
            // [Name]
            FormBuilder(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: _inputDecoration('    email@hawaii.edu'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: _inputDecoration('    UHM password'),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ))),
                    onPressed: () {
                      bool validEmailAndPassword =
                          _formKey.currentState?.saveAndValidate() ?? false;
                      UserDB userDB = ref.read(userDBProvider);

                      if (validEmailAndPassword) {
                        String email = _formKey.currentState?.value['email'];
                        if (userDB.isUserEmail(email)) {
                          ref.read(currentUserIDProvider.notifier).state =
                              userDB.getUserID(email);
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Unknown User"),
                            duration: Duration(seconds: 10),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Invalid Email or Password.'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: const Text('Enter')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
    ),
    filled: true,
    fillColor: const Color.fromRGBO(38, 95, 70, 1.0),
    hintStyle: TextStyle(color: Colors.grey[400]),
    hintText: hint,
  );
}
