import 'package:flutter/material.dart';


/// Displays a list of Gardens.
class ClassPage extends StatelessWidget {
  ClassPage({
    super.key, required this.title,
  });

  static const routeName = '/class';
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 95, 70, 1.0),
        title: Text(title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                height: 100,
                width: 375,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(

                      children: [
                        const SizedBox(width: 15.0),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/default_profile.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        Text('Student 1 Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(width: 30.0),
                        Text('Major',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                height: 100,
                width: 375,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(38, 95, 70, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(

                      children: [
                        const SizedBox(width: 15.0),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/default_profile.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        Text('Student 2 Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(width: 30.0),
                        Text('Major',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        ),
      );
  }
}

class Class {
  late List<Student> students;
}

class Student {
  late final String name;
  late final String major;
  late final String imgUrl;
}
