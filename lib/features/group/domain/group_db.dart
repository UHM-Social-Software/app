import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with groups.
class GroupData {
  GroupData({
    required this.id,
    required this.name,
    required this.description,
    required this.upcomingEvents,
    this.imagePath,
    required this.owner,
    required this.membership,
  });

  String id;
  String name;
  String description;
  String upcomingEvents;
  String? imagePath;
  String owner;
  List<String> membership;
}

/// Provides access to and operations on all defined groups.
class GroupDB {
  GroupDB(this.ref);

  final ProviderRef<GroupDB> ref;
  final List<GroupData> _groups = [
    GroupData(
        id: 'group-001',
        name: 'Chess Club',
        description: 'We are a fun chess club!',
        upcomingEvents: 'Oct 10th Round Robin Tournament',
        imagePath: 'assets/images/default_profile.png',
        owner: 'user-002',
        membership: ['user-002', 'user-001', 'user-003']),
    GroupData(
        id: 'group-002',
        name: 'Sailing Group',
        description: 'We are a fun Sailing Group!',
        upcomingEvents: 'Oct 20th: Learn About Knots',
        imagePath: 'assets/images/default_profile.png',
        owner: 'user-003',
        membership: ['user-003', 'user-001']),
    GroupData(
        id: 'group-003',
        name: 'UH Swim & Dive',
        description: 'We are a Swimming and Diving Team at UH!',
        upcomingEvents: 'USC, Santa Barbara, and UCSB @ USC October 13-14',
        imagePath: 'assets/images/default_profile.png',
        owner: 'user-001',
        membership: ['user-002', 'user-001', 'user-003']),
    GroupData(
        id: 'group-004',
        name: 'Group 4',
        description: 'Group 4',
        upcomingEvents: 'Cool stuff going on',
        imagePath: 'assets/images/default_profile.png',
        owner: 'user-001',
        membership: ['user-001', 'user-003']),
    GroupData(
        id: 'group-005',
        name: 'Group 5',
        description: 'Group 5',
        upcomingEvents: 'Very cool stuff going on',
        imagePath: 'assets/images/default_profile.png',
        owner: 'user-003',
        membership: ['user-003']),
  ];

  GroupData getGroup(String groupID) {
    return _groups.firstWhere((groupData) => groupData.id == groupID);
  }

  List<String> getGroupIDs() {
    List<String> groupIDs = [];
    for (var groupData in _groups) {
      groupIDs.add(groupData.id);
    }
    return groupIDs;
  }

  List<String> getGroupIDsFromList(List<GroupData> groups) {
    List<String> groupIDs = [];
    for (var groupData in groups) {
      groupIDs.add(groupData.id);
    }
    return groupIDs;
  }

  List<String> getMyGroupIDs(String ownerID) {
    return getGroupIDsFromList(
        _groups.where((groupData) => groupData.owner == ownerID).toList());
  }

  List<String> getMembers(String groupID) {
    return _groups
        .firstWhere((groupData) => groupData.id == groupID)
        .membership;
  }

  void createGroup({
    required String name,
    required String description,
    required String upcomingEvents,
    required String ownerID,
  }) {
    String id = 'group-${(_groups.length + 1).toString().padLeft(3, '0')}';
    String imagePath = 'assets/images/default_profile.png';
    List<String> membership = [ownerID];
    GroupData newGroup = GroupData(
        id: id,
        name: name,
        description: description,
        upcomingEvents: upcomingEvents,
        owner: ownerID,
        imagePath: imagePath,
        membership: membership);
    _groups.add(newGroup);
  }

  void updateGroup(
      String groupID,
    String newDescription,
    String newEvents,
  ) {
    GroupData group = _groups.firstWhere((groupData) => groupData.id == groupID);
    group.description = newDescription;
    group.upcomingEvents = newEvents;
  }

  void removeMember(String userID, String groupID){
    _groups.firstWhere((groupData) => groupData.id == groupID).membership.remove(userID);
  }

  void addMember(String userID, String groupID){
    _groups.firstWhere((groupData) => groupData.id == groupID).membership.add(userID);
  }
}
