import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantie/models/plant.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc() : super(PlantInitial()) {
    on<LoadPlants>((event, emit) async {
      // emit(const PlantLoaded(dbPlants, 1));
      // mock api call
      await Future.delayed(const Duration(seconds: 1), () {
        emit(const PlantLoaded(dbPlants, 1));
      });
    });
    on<AddPlant>((event, emit) {
      if (state is PlantLoaded) {
        final state = this.state as PlantLoaded;
        emit(PlantLoaded(
            List.from(state.plants)..add(event.plant), state.selectedPlant));
      }
    });
    on<RemovePlant>((event, emit) {
      if (state is PlantLoaded) {
        final state = this.state as PlantLoaded;
        emit(PlantLoaded(
            List.from(state.plants)..remove(event.plant), state.selectedPlant));
      }
    });
    on<SelectPlant>(
      (event, emit) {
        if (state is PlantLoaded) {
          final state = this.state as PlantLoaded;

          emit(PlantLoaded(
              state.plants,
              event.selectedPlant >= state.plants.length
                  ? 0
                  : event.selectedPlant));
        }
      },
    );
  }
}
