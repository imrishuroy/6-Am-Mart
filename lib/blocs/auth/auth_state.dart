part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  const AuthState({
    required this.status,
    required this.user,
  });

  // if user is not equal to null or user is signed In
  //we will get true and vise versa
  // bool isLoggedIn() => user != null && user?.userId != null;
  bool isLoggedIn() => user != null;

  factory AuthState.unknown() => const AuthState(
      status: AuthenticationStatus.unknown, user: User.emptyUser);

  factory AuthState.authenticated(User? user) =>
      AuthState(status: AuthenticationStatus.authenticated, user: user);

  factory AuthState.unauthenticated() => const AuthState(
      status: AuthenticationStatus.unauthenticated, user: User.emptyUser);

  @override
  List<Object?> get props => [status, user];
}
