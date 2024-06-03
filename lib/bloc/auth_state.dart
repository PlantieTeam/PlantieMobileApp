part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  const Authenticated({required this.user});
  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {
  final String message;
  const Unauthenticated({this.message = "none"});
}

class Loading extends AuthState {}

