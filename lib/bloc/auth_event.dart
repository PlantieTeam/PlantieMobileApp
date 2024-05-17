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

class SignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  const SignUp(
      {required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final String email;
  final String password;
  const LoggedIn({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class LoggedInWithGoogle extends AuthEvent {
  const LoggedInWithGoogle();
}

class LoggedOut extends AuthEvent {}
