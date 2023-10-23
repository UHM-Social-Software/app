import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/group_db.dart';

final groupDBProvider = Provider<GroupDB>((ref) {
  return GroupDB(ref);
});