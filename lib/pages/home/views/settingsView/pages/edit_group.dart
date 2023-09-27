import 'package:app/pages/home/views/settingsView/pages/my_groups.dart';
import 'package:flutter/material.dart';

import '../../../../../data_model/group_db.dart';

/// Displays a list of Gardens.
class EditGroup extends StatelessWidget {
  EditGroup({
    super.key,
    required this.groupName,
  });

  static const routeName = '/settings';
  String groupName;

  @override
  Widget build(BuildContext context) {
    List<String> memberList = groupDB.getMembers(groupName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editing: ' + groupName),
        backgroundColor: Color.fromRGBO(38, 95, 70, 1.0),
      ),
      body: Column(
        children: [
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
                  child: Text('Upload Club/Group Image',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
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
                      borderSide:
                          BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(38, 95, 70, 1.0),
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                    hintText: 'Enter New Club Description',
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
                      borderSide:
                          BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(38, 95, 70, 1.0),
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 20),
                    hintText: 'Enter New Upcoming Events List',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 43.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    height: 120,
                    width: 375,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(38, 95, 70, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Member List:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26)),
                          const SizedBox(height: 15.0),
                          Text(
                              memberList.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
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
