import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  final String name;
  final String description;
  final String image;

  const Plant(
      {required this.name, required this.description, required this.image});

  @override
  List<Object?> get props => [name, description, image];
}
