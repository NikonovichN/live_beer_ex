import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:equatable/equatable.dart';

part 'state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.initial());

  Future<void> register({
    required String phone,
    required String name,
    required DateTime birthDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        phone: phone,
        name: name,
        birthDate: birthDate,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void loginByPhone(String value) {
    state = state.copyWith(
      isAuthenticated: true,
      userId: 'user_123',
      phone: value,
      isGuestAuthenticated: false,
    );
  }

  void loginInWithoutRegistration() {
    state = state.copyWith(isGuestAuthenticated: true);
  }

  void logout() {
    state = const AuthState.initial();
  }
}

final authStreamProvider = StreamProvider<AuthState>((ref) {
  final notifier = ref.watch(authProvider.notifier);
  final controller = StreamController<AuthState>();

  notifier.addListener((state) => controller.add(state));

  ref.onDispose(() {
    controller.close();
  });

  return controller.stream;
});
