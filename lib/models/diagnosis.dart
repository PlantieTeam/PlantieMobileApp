import 'package:equatable/equatable.dart';

class Diagnosis extends Equatable {
  final String uid;
  final String prediction;
  final DateTime dateTime;

  const Diagnosis(
      {
      required this.uid,
      required this.prediction,
      required this.dateTime});
  toJson() {
    return {
      'uid': uid,
      'prediction': prediction,
      'dateTime': dateTime
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [ uid, prediction, dateTime];
}
