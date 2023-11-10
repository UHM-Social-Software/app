import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/group/domain/group.dart';
import '../features/group/presentation/edit_group_controller.dart';
import '../features/user/domain/user.dart';
import '../features/user/presentation/edit_user_controller.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{
  Future<String> uploadImageToStorage(String childName, Uint8List file, String id) async{
    Reference ref = _storage.ref().child(childName).child(id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
  Future<String> saveGroupImage({required Uint8List file, required Group group, required WidgetRef ref}) async {
    String resp = " Some Error Occured";
    try {
      String imageURL = await uploadImageToStorage('groupImages', file, group.id);
      Group updatedGroup = Group(
        id: group.id,
        name: group.name,
        description: group.description,
        upcomingEvents: group.upcomingEvents,
        imagePath: imageURL,
        owner: group.owner,
        membership: group.membership,
      );
      ref.read(editGroupControllerProvider.notifier).updateGroup(
        group: updatedGroup, onSuccess: () {  },
      );
      resp = 'success';
    } catch (err){
      resp = err.toString();
    }
    return resp;
  }

  Future<String> saveUserImage({required Uint8List file, required User user, required WidgetRef ref}) async {
    String resp = " Some Error Occured";
    try {
      String imageURL = await uploadImageToStorage('userImages', file, user.id);
      User updatedUser = User(
        id: user.id,
        name: user.name,
        interests: user.interests,
        groups: user.groups,
        email: user.email,
        classes: user.classes,
        imagePath: imageURL,
        bio: user.bio,
      );
      ref.read(editUserControllerProvider.notifier).updateUser(
        user: updatedUser,
        onSuccess: () {},
      );
      resp = 'success';
    } catch (err){
      resp = err.toString();
    }
    return resp;
  }
}