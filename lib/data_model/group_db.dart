/// The data associated with users.
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

/// Provides access to and operations on all defined users.
class GroupDB {
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
        membership: ['user-001','user-003']),
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
    _groups.forEach((groupData) => groupIDs.add(groupData.id));
    return groupIDs;
  }

  List<String> getGroupIDsFromList(List<GroupData> groups) {
    List<String> groupIDs = [];
    groups.forEach((groupData) => groupIDs.add(groupData.id));
    return groupIDs;
  }

  List<String> getMyGroupIDs(String ownerID) {
    return getGroupIDsFromList(_groups.where((groupData) => groupData.owner == ownerID).toList());
  }

  List<String> getMembers(String groupID){
    return _groups.firstWhere((groupData) => groupData.id == groupID).membership;
  }
}

/// The singleton instance providing access to all user data for clients.
GroupDB groupDB = GroupDB();
