import 'package:app/pages/views/profileView/pages/group_page.dart';
import 'package:flutter/material.dart';


/// Displays a list of Gardens.
class ExploreView extends StatelessWidget {
  const ExploreView({
    super.key,
  });

  static const routeName = '/ExploreView';
  final String title = 'ExploreView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
            ),
            filled: false,
            fillColor: Color.fromRGBO(38, 95, 70, .6),
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: 'Search',
          ),
        ),
        backgroundColor: Color.fromRGBO(38, 95, 70, .6),
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupPage(
                                title: 'Cool Chess Club',
                              )),
                    );
                  },
                  child: Text('Cool Chess Club',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
              SizedBox(width: 20.0),
              Container(
                alignment: Alignment.center,
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupPage(
                                title: 'Cooler Chess Club',
                              )),
                    );
                  },
                  child: Text('Cooler Chess Club',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              )
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupPage(
                                title: 'Ballroom Dance',
                              )),
                    );
                  },
                  child: Text('Ballroom Dance',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
              SizedBox(width: 20.0),
              Container(
                alignment: Alignment.center,
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupPage(
                                title: 'Sailing',
                              )),
                    );
                  },
                  child: Text('Sailing',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
