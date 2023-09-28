import 'package:app/data_model/user_db.dart';
import 'package:flutter/material.dart';


import '../../../../../data_model/class_db.dart';
import '../pages/class_page.dart';

/// Displays a news item given its ID.
class StudentBar extends StatelessWidget {
  const StudentBar({
    super.key,
    required this.studentName,
  });

  final String studentName;

  @override
  Widget build(BuildContext context) {
    UserData student = userDB.getStudent(studentName);
    return Column(
      children: [
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
                        image: AssetImage(student.imagePath.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Text(studentName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(width: 30.0),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
