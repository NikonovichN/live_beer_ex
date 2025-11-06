part of 'provider.dart';

class AuthState {
  final bool isAuthenticated;
  final String? userId;
  final String? email;

  const AuthState({required this.isAuthenticated, this.userId, this.email});

  AuthState copyWith({bool? isAuthenticated, String? userId, String? email}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userId: userId ?? this.userId,
      email: email ?? this.email,
    );
  }

  static const initial = AuthState(isAuthenticated: false);
}
