/// The data associated with users.
class GroupData {
  GroupData({
    required this.name,
    required this.description,
    required this.upcomingEvents,
    this.imagePath,
    required this.owner,
    required this.membership,
  });

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
        name: 'Chess Club',
        description: 'We are a fun chess club!',
        upcomingEvents: 'Oct 10th Round Robin Tournament',
        imagePath: 'assets/images/default_profile.png',
        owner: 'Bob McDonald',
        membership: ['Bob McDonald', 'Justin Lisoway', 'Donny Boy']),
    GroupData(
        name: 'Sailing Group',
        description: 'We are a fun Sailing Group!',
        upcomingEvents: 'Oct 20th: Learn About Knots',
        imagePath: 'assets/images/default_profile.png',
        owner: 'Donny Boy',
        membership: ['Donny Boy', 'Justin Lisoway']),
    GroupData(
        name: 'UH Swim & Dive',
        description: 'We are a Swimming and Diving Team at UH!',
        upcomingEvents: 'USC, Santa Barbara, and UCSB @ USC October 13-14',
        imagePath: 'assets/images/default_profile.png',
        owner: 'Justin Lisoway',
        membership: ['Bob McDonald', 'Justin Lisoway', 'Donny Boy']),
    GroupData(
        name: 'Group 4',
        description: 'Group 4',
        upcomingEvents: 'Group 4',
        imagePath: 'assets/images/default_profile.png',
        owner: 'Donny Boy',
        membership: ['Donny Boy']),
    GroupData(
        name: 'Group 5',
        description: 'Group 4',
        upcomingEvents: 'Group 4',
        imagePath: 'assets/images/default_profile.png',
        owner: 'Donny Boy',
        membership: ['Donny Boy']),
  ];

  GroupData getGroup(String groupName) {
    return _groups.firstWhere((groupData) => groupData.name == groupName);
  }

  List<String> getGroupNames() {
    List<String> groupNames = [];
    _groups.forEach((groupData) => groupNames.add(groupData.name));
    return groupNames;
  }

  List<GroupData> getGroups(GroupData group) {
    return _groups
        .where((groupData) => (groupData.owner == group.owner))
        .toList();
  }
}

/// The singleton instance providing access to all user data for clients.
GroupDB groupDB = GroupDB();
