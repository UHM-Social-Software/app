import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/group_database.dart';
import '../data/group_providers.dart';
import '../domain/group.dart';

part 'edit_group_controller.g.dart';

// The design of this controller is modeled on:
// https://codewithandrea.com/articles/flutter-navigate-without-context-gorouter-riverpod/
// https://codewithandrea.com/articles/async-notifier-mounted-riverpod/
// I am not in love with the "mounted" shenanigans. Sigh.
@riverpod
class EditGroupController extends _$EditGroupController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  Future<void> updateGroup({
    required Group group,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    GroupDatabase groupDatabase = ref.watch(groupDatabaseProvider);
    final newState =
    await AsyncValue.guard(() => groupDatabase.setGroup(group));
    if (mounted) {
      state = newState;
    }
    // Weird. Can't use "if (state.hasValue)" below.
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteGroup({
    required Group group,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    GroupDatabase groupDatabase = ref.watch(groupDatabaseProvider);
    final newState =
    await AsyncValue.guard(() => groupDatabase.deleteGroup(group));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
