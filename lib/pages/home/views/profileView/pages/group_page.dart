import 'package:flutter/material.dart';

import '../../../../../data_model/group_db.dart';

/// Displays a list of Gardens.
class GroupPage extends StatelessWidget {
  GroupPage({
    super.key,
    required this.groupID,
  });

  static const routeName = '/group';
  String groupID;

  @override
  Widget build(BuildContext context) {
    GroupData group = groupDB.getGroup(groupID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 95, 70, 1.0),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(group.imagePath.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      width: 375,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(38, 95, 70, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(group.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                      child: Column(
                        children: [
                          Text(group.description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                        padding: EdgeInsets.all(3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Upcoming Events:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26)),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(group.upcomingEvents,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 55,
                  width: 375,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(38, 95, 70, 1.0),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      // open messages
                    },
                    child: Text('Join / Request Invite',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
