part of 'provider.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isAuthenticated;
  final bool isGuestAuthenticated;
  final String? phone;
  final String? name;
  final String? userId;
  final DateTime? birthDate;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.isGuestAuthenticated = false,
    this.phone,
    this.name,
    this.userId,
    this.birthDate,
    this.error,
  });

  const AuthState.initial()
    : isLoading = false,
      isAuthenticated = false,
      isGuestAuthenticated = false,
      phone = null,
      name = null,
      userId = null,
      birthDate = null,
      error = null;

  @override
  List<Object?> get props => [
    isLoading,
    isAuthenticated,
    isGuestAuthenticated,
    phone,
    userId,
    name,
    birthDate,
    error,
  ];

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    bool? isGuestAuthenticated,
    String? userId,
    String? email,
    String? phone,
    String? name,
    DateTime? birthDate,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isGuestAuthenticated: isGuestAuthenticated ?? this.isGuestAuthenticated,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      birthDate: birthDate ?? this.birthDate,
      error: error ?? this.error,
    );
  }
}
