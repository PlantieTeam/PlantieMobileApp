part of 'plant_bloc.dart';

sealed class PlantState extends Equatable {
  const PlantState();
  
  @override
  List<Object> get props => [];
}

final class PlantInitial extends PlantState {}


final class PlantLoaded extends PlantState {
  final List<Plant> plants;
  const PlantLoaded(this.plants);
  @override
  List<Object> get props => [plants];
}
