import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/class_db.dart';

final classDBProvider = Provider<ClassDB>((ref) {
  return ClassDB(ref);
});