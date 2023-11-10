import 'user.dart';

/// Encapsulates operations on the list of [User] returned from Firestore.
class UserCollection{
  UserCollection(users) : _users = users;

  final List<User> _users;

  User getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<String> getUserNames(List<String> userIDs){
    List<User> givenUsers = [];
    for (var userID in userIDs) {givenUsers.add(getUser(userID));}
    List<String> userNames = [];
    for (var user in givenUsers) {
      userNames.add(user.name);
    }
    return userNames;
  }

  User getStudent(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<User> getUsers(List<String> userIDs) {
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

  /*
  void updateUserBio(String userID, String newBio){
    User user = _users.firstWhere((userData) => userData.id == userID).copyWith(bio: newBio);
  }

   */

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

  List<String> getNames() {
    List<String> names = [];
    for(User user in _users){
      names.add(user.name);
    }
    return names;
  }
}
