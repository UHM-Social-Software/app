/// Defines the domain model path strings for [FirestoreService].
class FirestorePath {
  static String user(String userID) => 'users/$userID';
  static String users() => 'users';

  static String course(String courseID) => 'users/$courseID';
  static String courses() => 'courses';

  static String group(String groupID) => 'groups/$groupID';
  static String groups() => 'groups';
}
