part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  // final AuthenticationStatus status;

  // const AuthStatusChanged(this.status);

  // @override
  // List<Object> get props => [status];
}

class AuthLogoutRequested extends AuthEvent {}
