part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  const AppStarted();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  const LoggedIn();

  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthEvent {}
