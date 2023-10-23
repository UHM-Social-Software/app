import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with users.
class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    required this.classes,
    this.interests,
    required this.groups,
    this.imagePath,
  });

  String id;
  String name;
  String email;
  String? bio;
  List<String> classes;
  List<String>? interests;
  List<String> groups;
  String? imagePath;
}

/// Provides access to and operations on all defined users.
class UserDB {
  UserDB(this.ref);
  final ProviderRef<UserDB> ref;
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
      groups: ['group-001','group-002','group-003', 'group-004'],
      imagePath: 'assets/images/user-001-profile.png',
    ),
    UserData(
      id: 'user-002',
      name: 'Bob McDonald',
      email: 'bMacs@hawaii.edu',
      bio: 'This is my bio',
      classes: ['ICS 491', 'ICS 314', 'ICS 311'],
      interests: ['ICS'],
      groups: ['group-001','group-003'],
      imagePath: 'assets/images/default_profile.png',
    ),
    UserData(
      id: 'user-003',
      name: 'Donny Boy',
      email: 'DBoy@hawaii.edu',
      bio: 'I really like food',
      classes: ['ICS 491', 'ICS 622', 'ICS 613'],
      interests: ['finance'],
      groups: ['group-001','group-002','group-003','group-004','group-005'],
      imagePath: 'assets/images/default_profile.png',
    ),
  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<String> getUserNames(List<String> userIDs){
    List<UserData> givenUsers = [];
    for (var userID in userIDs) {givenUsers.add(getUser(userID));}
    List<String> userNames = [];
    for (var user in givenUsers) {
      userNames.add(user.name);
    }
    return userNames;
  }

  UserData getStudent(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
  }

  List<String> getUserGroups(String userID){
    return _users.firstWhere((userData) => userData.id == userID).groups;
  }

  bool isUserEmail(String email) {
    List<String> emails = _users.map((userData) => userData.email).toList();
    return emails.contains(email);
  }

  String getUserID(String email) {
    return _users.firstWhere((userData) => userData.email == email).id;
  }

  String getUserIDWithName(String name) {
    return _users.firstWhere((userData) => userData.name == name).id;
  }

  String? getBio(String userID){
    return _users.firstWhere((userData) => userData.id == userID).bio;
  }

  void updateUserBio(String userID, String newBio){
    _users.firstWhere((userData) => userData.id == userID).bio = newBio;
  }

  void removeUserInterest(String userID, String interest){
    _users.firstWhere((userData) => userData.id == userID).interests?.remove(interest);
  }

  void addUserInterest(String userID, String interest){
    _users.firstWhere((userData) => userData.id == userID).interests?.add(interest);
  }

  void removeGroup(String userID, String groupID){
    _users.firstWhere((userData) => userData.id == userID).groups.remove(groupID);
  }

  void addGroup(String userID, String groupID){
    _users.firstWhere((userData) => userData.id == userID).groups.add(groupID);
  }
}
