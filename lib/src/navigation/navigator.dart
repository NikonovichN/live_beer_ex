import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/features.dart';
import 'main_tabs_screen.dart';

enum AppRouteNames {
  welcome,
  login,
  register,
  home,
  info,
  shops,
  profile;

  String get path => '/$this';
  String get name => '$this';
}

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
    initialLocation: AppRouteNames.welcome.path,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.isAuthenticated;
      final isAuthRoute =
          (state.fullPath?.contains(AppRouteNames.welcome.name) ?? false) ||
          (state.fullPath?.contains(AppRouteNames.login.name) ?? false) ||
          (state.fullPath?.contains(AppRouteNames.register.name) ?? false);

      if (!isAuthenticated && !isAuthRoute) {
        return AppRouteNames.login.path;
      }

      if (isAuthenticated && isAuthRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        name: AppRouteNames.welcome.name,
        path: AppRouteNames.welcome.path,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        name: AppRouteNames.login.name,
        path: AppRouteNames.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRouteNames.register.name,
        path: AppRouteNames.register.path,
        builder: (context, state) => const RegisterScreen(),
      ),
      // Main tabs with StatefulShellRoute
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainTabsScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteNames.home.name,
                path: AppRouteNames.home.path,
                builder: (context, state) => const HomeTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteNames.info.name,
                path: AppRouteNames.info.path,
                builder: (context, state) => const InfoTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteNames.shops.name,
                path: AppRouteNames.shops.path,
                builder: (context, state) => const ShopsTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteNames.profile.name,
                path: AppRouteNames.profile.path,
                builder: (context, state) => const ProfileTab(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
