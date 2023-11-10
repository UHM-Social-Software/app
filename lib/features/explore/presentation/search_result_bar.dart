import 'package:app/features/course/presentation/class_page.dart';
import 'package:app/features/group/domain/group.dart';
import 'package:app/features/user/domain/user.dart';
import 'package:app/features/user/presentation/profile_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../../group/domain/groups_collection.dart';
import '../../group/presentation/view_group_page.dart';
import '../../user/domain/user_collection.dart';


/// Displays a group bar linked to its viewing page given a group ID.
class SearchResultBar extends ConsumerWidget {
  const SearchResultBar({
    super.key,
    required this.data,
    required this.type,
  });

  final String? data;
  final String? type;


  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) =>
            _build(
              context: context,
              users: allData.users,
              groups: allData.groups,
            ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context, required List<User> users, required List<
          Group> groups}) {
    final groupCollection = GroupCollection(groups);
    final userCollection = UserCollection(users);

    var paddingSize = 12.0;

    if (type == "group") {
      Group group = groupCollection.getGroup(groupCollection.getIDFromName(data!));
      return Padding(
        padding: EdgeInsets.all(paddingSize),
        child: ListTile(
          title: Text(data!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          tileColor: Theme
              .of(context)
              .primaryColor, // Background color of the tile
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: group.imagePath.toString() == "assets/images/default_profile.png" ? AssetImage(group.imagePath.toString()) : NetworkImage(group.imagePath.toString()) as ImageProvider,
                fit: BoxFit.cover,
              )
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupPage(
                    groupID: group.id,
                      )),
            );
          },
        ),
      );
    } else if (type == "user") {
      User user = userCollection.getUser(userCollection.getUserIDWithName(data!));
      return Padding(
        padding: EdgeInsets.all(paddingSize),
        child: ListTile(
          title: Text(data!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          tileColor: Theme
              .of(context)
              .primaryColor, // Background color of the tile
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: user.imagePath.toString() == "assets/images/default_profile.png" ? AssetImage(user.imagePath.toString()) : NetworkImage(user.imagePath.toString()) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileViewerPage(
                    studentID: user.id,
                  )),
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(paddingSize),
        child: ListTile(
          title: Text(data!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          tileColor: Theme
              .of(context)
              .primaryColor, // Background color of the tile
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClassPage(
                    className: data!,
                  )),
            );
          },
        ),
      );
    }
  }
}
