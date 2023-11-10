import 'group.dart';

class GroupCollection {
  GroupCollection(groups) : _groups = groups;

  final List<Group> _groups;

  Group getGroup(String groupID) {
    return _groups.firstWhere((groupData) => groupData.id == groupID);
  }

  List<String> getGroupIDs() {
    List<String> groupIDs = [];
    for (var groupData in _groups) {
      groupIDs.add(groupData.id);
    }
    return groupIDs;
  }

  String getIDFromName(String name) {
    return _groups.firstWhere((groupData) => groupData.name == name).id;
  }

  int size() {
    return _groups.length;
  }

  List<String> getGroupIDsFromList(List<Group> groups) {
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

  void removeMember(String userID, String groupID){
    _groups.firstWhere((groupData) => groupData.id == groupID).membership.remove(userID);
  }

  void addMember(String userID, String groupID){
    _groups.firstWhere((groupData) => groupData.id == groupID).membership.add(userID);
  }

  List<String> getNames() {
    List<String> names = [];
    for(Group group in _groups){
      names.add(group.name);
    }
    return names;
  }
}