part of 'plant_bloc.dart';

sealed class PlantState extends Equatable {
  const PlantState();
  
  @override
  List<Object> get props => [];
}

final class PlantInitial extends PlantState {}


final class PlantLoaded extends PlantState {
  final List<Plant> plants;
  final int selectedPlant;
  const PlantLoaded(this.plants, this.selectedPlant);
  @override
  List<Object> get props => [plants, selectedPlant];
}
