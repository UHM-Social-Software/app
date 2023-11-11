import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/firestore/firestore_providers.dart';
import '../../authentication/presentation/signin_view2.dart';

/// Displays a button to return to the signin page.
class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 55,
          width: 375,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(38, 95, 70, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: MaterialButton(
            onPressed: () {
              final FirebaseAuth instance = ref.watch(firebaseAuthProvider);
              instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInView2()),
              );
            },
            child: const Text('Logout',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold, fontSize: 30)),
          ),
        ),
      ],
    );
  }
}
