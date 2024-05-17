import 'package:equatable/equatable.dart';

enum UserStatus { loggedIn, loggedOut }

enum UserError {
  none,
  invalidCredentials,
  emailAlreadyInUse,
  invalidEmail,
  weakPassword,
  wrongPassword
}

class UserModel extends Equatable {
  final UserStatus userStatus;
  final UserError userError;

  const UserModel(
      {this.userStatus = UserStatus.loggedOut,
      this.userError = UserError.none});
  @override
  List<Object?> get props => [userStatus, userError];
}

const Map<UserError, String> errorMassages = {
  UserError.invalidCredentials: 'Invalid credentials',
  UserError.emailAlreadyInUse: 'Email already in use',
  UserError.invalidEmail: 'Invalid email',
  UserError.weakPassword: 'Weak password',
  UserError.wrongPassword: 'Wrong password',
};
