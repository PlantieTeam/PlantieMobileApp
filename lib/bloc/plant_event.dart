part of 'plant_bloc.dart';

sealed class PlantEvent extends Equatable {
  const PlantEvent();

  @override
  List<Object> get props => [];
}

class LoadPlants extends PlantEvent {}

class AddPlant extends PlantEvent {
  final Plant plant;

  const AddPlant({required this.plant});
  @override
  List<Object> get props => [plant];
}

class RemovePlant extends PlantEvent {
  final Plant plant;

  const RemovePlant({required this.plant});

  @override
  List<Object> get props => [plant];
}
