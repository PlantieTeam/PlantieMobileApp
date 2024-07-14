part of 'user_profile_bloc.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}
class UserProfileLoaded extends UserProfileState {
  final UserProfile userProfile;

  UserProfileLoaded(this.userProfile);
    
  @override
  List<Object> get props => [userProfile];

}

