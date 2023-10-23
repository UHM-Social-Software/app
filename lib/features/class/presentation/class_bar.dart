import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../data/class_providers.dart';
import '../domain/class_db.dart';
import 'class_page.dart';

/// Displays a class item given its class name.
class ClassBar extends ConsumerWidget {
  const ClassBar({
    super.key,
    required this.className,
  });

  final String className;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ClassDB classDB = ref.watch(classDBProvider);
    ClassData currentClass = classDB.getClass(className);

    return Column(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClassPage(
                      className: currentClass.name,
                    )),
              );
            },
            child: Text(currentClass.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
