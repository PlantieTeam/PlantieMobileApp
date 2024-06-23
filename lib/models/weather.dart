import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String? status;
  final String? location;
  final double? temperature;
  final String? suggestion;
  final String? timeOfRain;
  final int? humidity;
  final double? windSpeed;
  Weather({
    this.status,
    this.location ,
    this.temperature,
    this.suggestion ,
    this.timeOfRain,
    this.humidity,
    this.windSpeed
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, location, temperature, suggestion, timeOfRain, humidity];
}
