import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantie/models/UserProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<GetLangauge>((event, emit) async {
      // Fetch the language from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final String? language = prefs.getString('language');
      
      // If no language is found, default to 'en'
      final userProfile = UserProfile(language: language ?? 'en');
      
      // Emit the loaded state
      emit(UserProfileLoaded(userProfile));
    });
 on<UpdateLanguage>((event, emit) async {
      // Save the new language to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', event.langauge);
      print(event.langauge);
      // Emit the new state with the updated language
      final userProfile = UserProfile(language: event.langauge);
      emit(UserProfileLoaded(userProfile));
    });
  }
  // Method to store the user profile in shared preferences

  //   Future<void> saveUserProfile(UserProfile userProfile) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('language', userProfile.language);
  // }
}
