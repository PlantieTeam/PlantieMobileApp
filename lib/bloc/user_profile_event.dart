part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetLangauge extends UserProfileEvent{
  const GetLangauge();
  @override
  List<Object> get props => [];
}

class ChangeLanguage extends  UserProfileEvent{
  final String langauge;
    const ChangeLanguage({required  this.langauge});
  @override
  List<Object> get props => [langauge];
}
class UpdateLanguage extends UserProfileEvent {
 final String langauge;
    const UpdateLanguage({required  this.langauge});
  @override
  List<Object> get props => [langauge];
}