import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

part 'state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial);

  void login(String email, String password) {
    state = state.copyWith(isAuthenticated: true, userId: 'user_123', email: email);
  }

  void register(String email, String password, String confirmPassword) {
    state = state.copyWith(isAuthenticated: true, userId: 'user_123', email: email);
  }

  void logout() {
    state = AuthState.initial;
  }
}

final authStreamProvider = StreamProvider<AuthState>((ref) {
  final notifier = ref.watch(authProvider.notifier);
  final controller = StreamController<AuthState>();

  notifier.addListener((state) => controller.add(state));

  ref.onDispose(() {
    notifier.dispose();
    controller.close();
  });

  return controller.stream;
});
