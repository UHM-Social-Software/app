import 'package:app/features/explore/presentation/explore_view.dart';
import 'package:app/features/messaging/presentation/messaging_screen.dart';
import 'package:app/features/messaging/application/messaging_service.dart';
import 'package:app/features/class/presentation/class_page.dart';
import 'package:app/features/group/presentation/create_group_page.dart';
import 'package:app/features/group/presentation/edit_group_page.dart';
import 'package:app/features/group/presentation/view_group_page.dart';
import 'package:app/features/group/presentation/owned_groups.dart';
import 'package:app/features/user/presentation/profile_view.dart';
import 'package:flutter/material.dart';
import 'features/home/presentation/home_view.dart';
import 'features/authentication/presentation/signin_view.dart';
import 'features/settings/presentation/settings_view.dart';


/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  final FirebaseMessagingService _firebaseMessagingService = FirebaseMessagingService();

  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    _firebaseMessagingService.initialize();
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(81, 202, 149, 1.0),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(81, 202, 149, 1.0),
        ),
        primaryColor: const Color.fromRGBO(38, 95, 70, 1.0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
            // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
        textTheme:
            const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      // darkTheme: ThemeData.dark(),
      // themeMode: settingsController.themeMode,

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case HomeView.routeName:
                return HomeView();
              case ProfileView.routeName:
                return ProfileView();
              case ExploreView.routeName:
                return const ExploreView();
              /*case MessagesView.routeName:
                return MessagesView();*/
              case MessagingScreen.routeName:
                return const MessagingScreen();
              case SettingsView.routeName:
                return const SettingsView();
              case MyGroups.routeName:
                return const MyGroups();
              case CreateGroup.routeName:
                return CreateGroup();
              case EditGroup.routeName:
                return EditGroup(groupID: '',);
              case ClassPage.routeName:
                return const ClassPage(
                  className: '',
                );
              case GroupPage.routeName:
                return const GroupPage(
                  groupID: '',
                );
              case SigninView.routeName:
                return SigninView();
              default:
                return SigninView();
            }
          },
        );
      },
    );
  }
}