import 'package:firebase_messaging/firebase_messaging.dart';

/*
* This service is a modified copy and paste version of a service found online. Right now its serving as a temporary messaging service as I explore and figure out how to use firebase.
* */
class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for notifications (only needed for iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Configure the callbacks for handling messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Handle incoming message when the app is in the foreground
        print("onMessage: ${message.data}");
        // You can update the UI or display a local notification here
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // Handle when the user taps the notification (app is in the background)
        print("onMessageOpenedApp: ${message.data}");
        // You can navigate to a specific screen or perform an action
      });

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }
  }

  // Add more methods here for sending messages, subscribing to topics, etc.

  // Define a background message handler
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.data}");
    // Handle the message when the app is in the background or terminated
  }

  void sendMessage(String messageText) {}
}
