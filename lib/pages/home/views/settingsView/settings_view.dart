import 'package:app/pages/home/views/settingsView/pages/create_group.dart';
import 'package:app/pages/home/views/settingsView/pages/my_groups.dart';
import 'package:flutter/material.dart';

import '../../../signin_view.dart';

/// Displays a list of Gardens.
class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  static const routeName = '/settings';
  final String title = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 55,
                width: 375,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninView()),
                    );
                  },
                  child: Text('Logout',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold, fontSize: 30)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 43.0),
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
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninView()),
                    );*/
                  },
                  child: Text('Upload Profile Photo',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 100,
                width: 375,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextField(
                  maxLines: 3,
                  minLines: 2,
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
                    hintText: 'Enter New Bio',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
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
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninView()),
                    );*/
                  },
                  child: Text('Add or Delete Interests',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 43.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 45,
                width: 375,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateGroup()),
                    );
                  },
                  child: Text('Create Group',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 45,
                width: 375,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyGroups()),
                    );
                  },
                  child: Text('My Groups',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
