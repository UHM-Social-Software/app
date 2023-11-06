import 'package:app/features/user/domain/user_collection.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../home/presentation/home_view.dart';
import '../../user/domain/user.dart';
import '../../user/presentation/edit_user_controller.dart';
import 'decorations.dart';
import 'forgot_password_view.dart';
import 'verify_email_view.dart';

/// Builds the page containing fields to enter a username and password, plus buttons.
class SignInView2 extends ConsumerWidget {
  const SignInView2({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) =>
            _build(
              context: context,
              users: allData.users,
              ref: ref,),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users, required WidgetRef ref,
  }) {
    final userCollection = UserCollection(users);
    return SignInScreen(
      actions: [
        ForgotPasswordAction((context, email) {
          Navigator.pushNamed(
            context,
            ForgotPasswordView.routeName,
            arguments: {'email': email},
          );
        }),
        AuthStateChangeAction<SignedIn>((context, state) {
          if (!state.user!.emailVerified) {
            Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          }
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          if (!state.credential.user!.emailVerified) {
            String email = state.credential.user?.email ?? '';
            String id = state.credential.user?.uid ?? '';
            User newUser;
            if(userCollection.isUserEmail(email)) {
              User existingUserData = userCollection.getUser(userCollection.getUserID(email));
              newUser = User(
                  id: id,
                  bio: existingUserData.bio,
                  name: existingUserData.name,
                  email: email,
                  classes: existingUserData.classes,
                  groups: existingUserData.groups,
                  imagePath: existingUserData.imagePath,
                  interests: existingUserData.interests);
              ref.read(editUserControllerProvider.notifier).deleteUser(
                user: existingUserData,
                onSuccess: () {},
              );
            } else {
              newUser = User(
                  id: id,
                  bio: "",
                  name: email,
                  email: email,
                  classes: [],
                  groups: [],
                  imagePath: 'assets/images/user-001-profile.png',
                  interests: []);
            }
            ref.read(editUserControllerProvider.notifier).updateUser(
              user: newUser,
              onSuccess: () {},
            );
          Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
          }
        }),
        AuthStateChangeAction<CredentialLinked>((context, state) {
          if (!state.user.emailVerified) {
            Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          }
        }),
      ],
      styles: const {
        EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
      },
      headerBuilder: headerImage('assets/images/manoaseal_transparent.png'),
      sideBuilder: sideImage('assets/images/manoaseal_transparent.png'),
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            action == AuthAction.signIn
                ? 'Welcome to Meet Your People!'
                : 'Welcome to Agile Garden Club! Please create an account.',
          ),
        );
      },
      footerBuilder: (context, action) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              action == AuthAction.signIn
                  ? 'By signing in, you agree to our terms and conditions.'
                  : 'By registering, you agree to our terms and conditions.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
