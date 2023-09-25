import 'package:flutter/material.dart';

/// Presents the page containing fields to enter a username and password, plus buttons.
class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(
                  "Welcome to ''Meet Your People''",
                  textScaleFactor: 2,
                  style: TextStyle(fontFamily: 'Chancery'),
                ),
              ],
            ),
            const SizedBox(height: 200.0),
            // [Name]
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                ),
                filled: true,
                fillColor: Color.fromRGBO(38, 95, 70, 1.0),
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: '    email@hawaii.edu',
              ),
            ),

            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                ),
                filled: true,
                fillColor: Color.fromRGBO(38, 95, 70, 1.0),
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: '    UHM Password',
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 1.0),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ))),
                    onPressed: () {
                      // Eventually: pushReplacementNamed
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('Enter')),
                const SizedBox(width: 1.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
