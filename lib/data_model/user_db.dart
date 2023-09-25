/// The data associated with users.
class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    required this.classes,
    this.interests,
    this.groups,
    this.imagePath,
  });

  String id;
  String name;
  String email;
  String? bio;
  List<String> classes;
  List<String>? interests;
  List<String>? groups;
  String? imagePath;
}

class Group {
  Group({
    required this.id,
    required this.name,
    required this.description,
    required this.upcomingEvents,
    required this.membership,
    this.imagePath,
  });

  String id;
  String name;
  String description;
  String upcomingEvents;
  List<UserData> membership;
  String? imagePath;
}

/// Provides access to and operations on all defined users.
class UserDB {
  final List<UserData> _users = [
    UserData(
      id: 'user-001',
      name: 'Justin Lisoway',
      email: 'jlisoway@hawaii.edu',
      bio: 'I am a student at UH!!!',
      classes: [
        'ICS 491',
        'ICS 691D',
        'ICS 691E',
        'ICS 690',
        'ICS 622',
        'ICS 613'
      ],
      interests: ['swimming', 'ICS', 'finance'],
      groups: ['UH Swim & Dive'],
      imagePath: 'assets/images/user-001.jpg',
    ),
    UserData(
      id: 'user-001',
      name: 'Bob McDonald',
      email: 'bMacs@hawaii.edu',
      bio: 'This is my bio',
      classes: ['ICS 491', 'ICS 314', 'ICS 311'],
      interests: ['ICS'],
      groups: [],
      imagePath: 'assets/images/user-001.jpg',
    ),
    UserData(
      id: 'user-001',
      name: 'Donny Boy',
      email: 'DBoy@hawaii.edu',
      bio: 'I really like food',
      classes: ['ICS 491', 'ICS 622', 'ICS 613'],
      interests: ['finance'],
      groups: [],
      imagePath: 'assets/images/user-001.jpg',
    ),
  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
  }

  /// The singleton instance providing access to all user data for clients.
  UserDB userDB = UserDB();

  /// The currently logged in user.
  String currentUserID = 'user-001';
}
