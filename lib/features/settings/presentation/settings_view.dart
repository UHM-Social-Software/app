import 'package:app/features/group/presentation/create_group_button.dart';
import 'package:app/features/user/presentation/edit_bio_form.dart';
import 'package:app/features/user/presentation/edit_interests.dart';
import 'package:app/features/group/presentation/owned_groups_button.dart';
import 'package:app/features/user/presentation/upload_profile_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/settings/presentation/logout_button.dart';

/// High level display of the settings page.
class SettingsView extends ConsumerWidget {
  const SettingsView({
    super.key,
  });

  static const routeName = '/settings';
  final String title = 'settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          const LogoutButton(),
          Flexible(
            child: SizedBox(
              height: 696,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    const ProfilePhotoButton(),
                    const SizedBox(height: 20.0),
                    EditBioForm(),
                    const SizedBox(height: 30.0),
                    EditInterests(),
                    const SizedBox(height: 30.0),
                    const CreateGroupButton(),
                    const SizedBox(height: 10.0,),
                    const MyGroupsButton(),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
