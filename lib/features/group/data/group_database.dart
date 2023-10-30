import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/group.dart';

/// Provides access to the Firestore database storing [Group] documents.
class GroupDatabase {
  GroupDatabase(this.ref);

  final ProviderRef<GroupDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Group>> watchGroups() => _service.watchCollection(
      path: FirestorePath.groups(),
      builder: (data, documentId) => Group.fromJson(data!));

  Stream<Group> watchGroup(String groupId) => _service.watchDocument(
      path: FirestorePath.group(groupId),
      builder: (data, documentId) => Group.fromJson(data!));

  Future<List<Group>> fetchGroups() => _service.fetchCollection(
      path: FirestorePath.groups(),
      builder: (data, documentId) => Group.fromJson(data!));

  Future<Group> fetchGroup(String groupId) => _service.fetchDocument(
      path: FirestorePath.group(groupId),
      builder: (data, documentId) => Group.fromJson(data!));

  Future<void> setGroup(Group group) => _service.setData(
      path: FirestorePath.group(group.id), data: group.toJson());

  Future<void> deleteGroup(Group group) =>
      _service.deleteData(path: FirestorePath.group(group.id));
}
