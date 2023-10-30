import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/user_database.dart';
import '../data/user_providers.dart';
import '../domain/user.dart';


part 'edit_user_controller.g.dart';

// The design of this controller is modeled on:
// https://codewithandrea.com/articles/flutter-navigate-without-context-gorouter-riverpod/
// https://codewithandrea.com/articles/async-notifier-mounted-riverpod/
// I am not in love with the "mounted" shenanigans. Sigh.
@riverpod
class EditUserController extends _$EditUserController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  Future<void> updateUser({
    required User user,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    UserDatabase userDatabase = ref.watch(userDatabaseProvider);
    final newState =
    await AsyncValue.guard(() => userDatabase.setUser(user));
    if (mounted) {
      state = newState;
    }
    // Weird. Can't use "if (state.hasValue)" below.
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteUser({
    required User user,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    UserDatabase userDatabase = ref.watch(userDatabaseProvider);
    final newState =
    await AsyncValue.guard(() => userDatabase.deleteUser(user));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
