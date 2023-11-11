import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../../repositories/add_data.dart';
import '../../../utils.dart';
import '../../all_data_provider.dart';
import '../domain/user.dart';
import '../domain/user_collection.dart';

class ProfilePhotoButton extends ConsumerWidget {
  const ProfilePhotoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          users: allData.users,
          ref: ref,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> users, required WidgetRef ref,
  }) {
    final userCollection = UserCollection(users);
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserID = currentUser!.uid;
    User user = userCollection.getUser(currentUserID);

    Uint8List? _image;

    void selectImage() async {
      _image = await pickImage(ImageSource.gallery);
      String resp = await StoreData().saveUserImage(file: _image!, user: user, ref: ref);
    }

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
            onPressed: selectImage,
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
