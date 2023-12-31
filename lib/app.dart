
import 'package:app/pages/views/explore_view.dart';
import 'package:app/pages/views/messages_view.dart';
import 'package:app/pages/views/profileView/pages/class_page.dart';
import 'package:app/pages/views/profileView/pages/create_group.dart';
import 'package:app/pages/views/profileView/pages/edit_group.dart';
import 'package:app/pages/views/profileView/pages/group_page.dart';
import 'package:app/pages/views/profileView/pages/my_groups.dart';
import 'package:app/pages/views/profileView/profile_view.dart';
import 'package:app/pages/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'pages/home/home_view.dart';
import 'pages/signin/signin_view.dart';


/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(81, 202, 149, 1.0),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color.fromRGBO(81, 202, 149, 1.0),
        ),
        primaryColor: Color.fromRGBO(38, 95, 70, 1.0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(38, 95, 70, 1.0),
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
                return ExploreView();
              case MessagesView.routeName:
                return MessagesView();
              case SettingsView.routeName:
                return SettingsView();
              case MyGroups.routeName:
                return MyGroups();
              case CreateGroup.routeName:
                return CreateGroup();
              case EditGroup.routeName:
                return EditGroup(title: '',);
              case ClassPage.routeName:
                return ClassPage(
                  title: '',
                );
              case GroupPage.routeName:
                return GroupPage(
                  title: '',
                );
              case SigninView.routeName:
                return const SigninView();
              default:
                return const SigninView();
            }
          },
        );
      },
    );
  }
}