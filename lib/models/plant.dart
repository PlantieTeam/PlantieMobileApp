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

const List<Plant> dbPlants = [
  Plant(name: 'Apple', description: 'Fruit', image: 'assets/images/apple.png'),
  Plant(
      name: 'Green Beans',
      description: 'Vegetable',
      image: 'assets/images/green-beans.png'),
  Plant(
      name: 'Corn', description: 'Vegetable', image: 'assets/images/corn.png'),
  Plant(
      name: 'Cucumber',
      description: 'Vegetable',
      image: 'assets/images/cucumber.png'),
  Plant(
      name: 'Grapes', description: 'Fruit', image: 'assets/images/grapes.png'),
  Plant(
      name: 'Pepper',
      description: 'Vegetable',
      image: 'assets/images/pepper.png'),
  Plant(
      name: 'Potato',
      description: 'Vegetable',
      image: 'assets/images/potato.png'),
  Plant(
      name: 'Olives',
      description: 'Vegetable',
      image: 'assets/images/olives.png'),
  Plant(
      name: 'Tomato',
      description: 'Vegetable',
      image: 'assets/images/tomato.png'),
  Plant(
      name: 'Strawberry',
      description: 'Fruit',
      image: 'assets/images/strawberry.png'),
];
