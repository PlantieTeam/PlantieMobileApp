import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantie/bloc/plant_bloc.dart';
import 'package:plantie/pages/fertilizer_calculator_page.dart';
import 'package:plantie/shared/custom_listView.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:plantie/shared/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  double ratio = 0.95;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantBloc, PlantState>(builder: (context, state) {
      if (state is PlantInitial) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is PlantLoaded &&
          state.plants.isNotEmpty &&
          state.plants.length > state.selectedPlant) {
        return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const WeatherCard(
                    status: WeatherStatus.sunny,
                    location: "Palestine Jenin",
                    temperature: 30,
                    suggestion: "Good for applying the fertilizers",
                    timeOfRain: "10:00 AM",
                    humidity: "50"),
                Container(
                  width: MediaQuery.of(context).size.width * ratio,
                  height: 75,
                  margin: const EdgeInsets.only(top: 20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Weather",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Weather Today is good for applying the fertilizers",
                        style:
                            TextStyle(color: Color(0xff465165), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * ratio,
                    // height: 100,
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Choose Your Plant",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                        CustomListView(
                          selectedIndex: state.selectedPlant,
                          onTap: (int index) {
                            context
                                .read<PlantBloc>()
                                .add(SelectPlant(selectedPlant: index));
                          },
                        )
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * ratio,
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(state.plants[state.selectedPlant].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Button(
                          text: "Calculate Fertilizer",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FertilizerCalculatorPage()));
                          },
                        )),
                        Container(
                          width: MediaQuery.of(context).size.width * ratio,
                          // height: 400,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Growing season",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    // "They typically grow best in late spring, summer, and early fall in most climates.",
                                    state.plants[state.selectedPlant]
                                        .description,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff465165))),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Water Need",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("1 inch of water per week",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff465165))),
                                const SizedBox(height: 20),
                                Button(text: "Read more", onPressed: () {})
                              ]),
                        )
                      ],
                    )),
                // SizedBox(height: 20,),

                const SizedBox(
                  height: 100,
                )
              ],
            )));
      }
      return const Center(
        child: Text("Not Found 404"),
      );
    });
  }
}
