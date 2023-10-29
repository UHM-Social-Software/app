import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/messaging/application/firebase_options.dart';
import 'app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool> verifyInitialData() async {
  // logger.i('Verifying initial data files: Chapter, Garden, News, User');
  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'UHM-Social-Software',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  // await verifyInitialData();
  runApp(ProviderScope(child: MyApp()));
}