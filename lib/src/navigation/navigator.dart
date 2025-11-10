import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/features.dart';
import 'main_tabs_screen.dart';

class GoRouterAuthNotifier extends ChangeNotifier {
  GoRouterAuthNotifier(this.ref) {
    ref.listen<AuthState>(authProvider, (_, __) {
      notifyListeners();
    });
  }

  final Ref ref;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = GoRouterAuthNotifier(ref);
  return GoRouter(
    initialLocation: '/welcome',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.isAuthenticated;
      final isAuthRoute =
          (state.fullPath?.contains('welcome') ?? false) ||
          (state.fullPath?.contains('login') ?? false) ||
          (state.fullPath?.contains('register') ?? false);

      if (!isAuthenticated && !isAuthRoute) {
        return '/login';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      // Main tabs with StatefulShellRoute
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainTabsScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: '/', builder: (context, state) => const HomeTab())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/info', builder: (context, state) => const InfoTab())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/shops', builder: (context, state) => const ShopsTab())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/profile', builder: (context, state) => const ProfileTab())],
          ),
        ],
      ),
    ],
  );
});
