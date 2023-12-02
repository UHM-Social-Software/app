import 'package:app/features/course/domain/course.dart';
import 'package:app/features/course/domain/course_collection.dart';
import 'package:app/features/explore/presentation/explore_group_card.dart';
import 'package:app/features/explore/presentation/search_result_bar.dart';
import 'package:app/features/user/domain/user.dart';
import 'package:app/features/user/domain/user_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../group/domain/group.dart';
import '../../group/domain/groups_collection.dart';

/// Displays a list of groups in the database.
class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({
    super.key,
  });

  static const routeName = '/ExploreView';

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}


class _ExploreViewState extends ConsumerState<ExploreView> {

  final String title = 'ExploreView';
  List<Map<String, String>> searchResults = [];
  bool showResults = false;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          groups: allData.groups,
          users: allData.users,
          courses: allData.courses,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
        required List<Group> groups, required List<User> users, required List<Course> courses}) {
    final groupCollection = GroupCollection(groups);
    final userCollection = UserCollection(users);
    final courseCollection = CourseCollection(courses);
    List<String> groupIDs = groupCollection.getGroupIDs();

    List<String> groupNames = groupCollection.getNames();
    List<String> userNames = userCollection.getNames();
    List<String> courseNames = courseCollection.getNames();


    void performSearch(String query) {
      List<Map<String, String>> results = [];


      for (String name in groupNames){
        if (name.toLowerCase().contains(query.toLowerCase())) {
          results.add({'type': 'group', 'data': name});
        }
      }

      for (String name in userNames){
        if (name.toLowerCase().contains(query.toLowerCase())) {
          results.add({'type': 'user', 'data': name});
        }
      }

      for (String name in courseNames) {
        if (name.toLowerCase().contains(query.toLowerCase())) {
          results.add({'type': 'course', 'data': name});
        }
      }


      setState(() {
        if(query != ''){
          showResults = true;
        }
        searchResults = results;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.0)),
            ),
            filled: false,
            fillColor: const Color.fromRGBO(38, 95, 70, .6),
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: 'Search',
          ),
          onChanged: performSearch,
        ),
        backgroundColor: const Color.fromRGBO(38, 95, 70, .6),
        toolbarHeight: 60.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      body: _buildSearchResults(groupIDs),
    );
  }



  Widget _buildSearchResults(List<String> groupIDs) {
    if(showResults){
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var result = searchResults[index];
          var type = result['type'];
          var data = result['data'];

          return SearchResultBar(type: type, data: data);
        },
      );
    } else {
      return blankSearchView(groupIDs);
    }
  }

  Widget blankSearchView(List<String> groupIDs) {
    return GridView(
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        ...groupIDs.map((groupID) => ExploreGroupCard(groupID: groupID))
      ],
    );
  }
}


