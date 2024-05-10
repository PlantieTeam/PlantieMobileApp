import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantie/bloc/plant_bloc.dart';
import 'package:plantie/models/plant.dart';
import 'package:plantie/pages/landing_page.dart';
import 'package:plantie/shared/custom_listView.dart';
import 'package:plantie/shared/custome_button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlantBloc()..add(LoadPlants()),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: BlocBuilder<PlantBloc, PlantState>(
              builder: (context, state) {
                if (state is PlantInitial) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                  ));
                }
                if (state is PlantLoaded) {
                  return Column(
                    children: [
                      Text(state.plants.length.toString()),
                      ElevatedButton(
                        child: const Text("hello"),
                        onPressed: () {
                          context.read<PlantBloc>().add(const AddPlant(
                              plant: Plant(
                                  name: "Apple",
                                  description: "apple",
                                  image: "apple")));
                        },
                      )
                      // Add your widgets here based on the TestLoaded state
                    ],
                  );
                }
                // Handle other states if needed
                return const Text(
                    "An Error Occurred"); // Return a default widget or null
              },
            ),
          ),
        ),
      ),
    );
  }
}
