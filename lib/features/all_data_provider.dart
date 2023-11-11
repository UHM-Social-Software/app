import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'course/data/course_providers.dart';
import 'course/domain/course.dart';
import 'group/data/group_providers.dart';
import 'group/domain/group.dart';
import 'user/domain/user.dart';
import 'user/data/user_providers.dart';


part 'all_data_provider.g.dart';

// Based on: https://stackoverflow.com/questions/69929734/combining-futureproviders-using-a-futureprovider-riverpod

class AllData {
  AllData(
      {required this.users,
      required this.courses,
      required this.groups});

  final List<User> users;
  final List<Course> courses;
  final List<Group> groups;
}

@riverpod
Future<AllData> allData(AllDataRef ref) async {
  final courses = ref.watch(coursesProvider.future);
  final groups = ref.watch(groupsProvider.future);
  final users = ref.watch(usersProvider.future);
  return AllData(
      courses: await courses,
      groups: await groups,
      users: await users);
}
