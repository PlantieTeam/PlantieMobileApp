import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantie/models/plant.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc() : super(PlantInitial()) {
    on<LoadPlants>((event, emit) {
      // mock api call
      Future.delayed(const Duration(seconds: 1), () {
        emit(const PlantLoaded(<Plant>[]));
      });
    });
    on<AddPlant>((event, emit) {
      if (state is PlantLoaded) {
        final state = this.state as PlantLoaded;
        emit(PlantLoaded(List.from(state.plants)..add(event.plant)));
      }
    });
    on<RemovePlant>((event, emit) {
      if (state is PlantLoaded) {
        final state = this.state as PlantLoaded;
        emit(PlantLoaded(List.from(state.plants)..remove(event.plant)));
      }
    });
  }
}
