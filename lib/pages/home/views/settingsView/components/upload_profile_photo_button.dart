import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays a news item given its ID.
class ProfilePhotoButton extends ConsumerWidget {
  const ProfilePhotoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
              /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninView()),
                    );*/
            },
            child: const Text('Upload Profile Photo',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
