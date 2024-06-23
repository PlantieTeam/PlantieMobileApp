import 'package:equatable/equatable.dart';

class Diagnosis extends Equatable {
  final String uid;
  final String prediction;
  final DateTime dateTime;
  final String path;

  const Diagnosis(
      {required this.uid,
      required this.prediction,
      required this.dateTime,
      required this.path});
  toJson() {
    return {
      'uid': uid,
      'prediction': prediction,
      'dateTime': dateTime.toString(),
      "path": path
    };
  }

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      prediction: json['prediction'],
      dateTime: DateTime.parse(json['dateTime']),
      uid: json['uid'],
      path: json['path'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uid, prediction, dateTime];
}
