import 'package:equatable/equatable.dart';

class UserProfile extends Equatable{
  final String language;

  UserProfile({required this.language});

  Map<String, dynamic> toJson() => {
        'language': language,
      };

  static UserProfile fromJson(Map<String, dynamic> json) => UserProfile(
        language: json['language'],
      );
      
        @override
        // TODO: implement props
        List<Object?> get props => [language];
}
