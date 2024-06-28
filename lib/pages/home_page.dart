import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantie/bloc/plant_bloc.dart';
import 'package:plantie/models/plant.dart';
import 'package:plantie/models/weather.dart';
import 'package:plantie/pages/camera_result.dart';
import 'package:plantie/pages/fertilizer_calculator_page.dart';
import 'package:plantie/services/weather_prediction.dart';
import 'package:plantie/shared/custom_listView.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:plantie/shared/loader.dart';
import 'package:plantie/shared/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.weatherData});
  final Weather weatherData;

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  double ratio = 0.95;
  double temp = 0.0;
  Langauge lang = Langauge.arabic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantBloc, PlantState>(builder: (context, state) {
      if (state is PlantInitial) {
        return const Center(child: Loader());
      }
      if (state is PlantLoaded &&
          state.plants.isNotEmpty &&
          state.plants.length > state.selectedPlant) {
        return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
                child: Column(
              textDirection: lang == Langauge.arabic
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.weatherData.temperature != null
                    ? WeatherCard(
                        status: widget.weatherData.status!,
                        location: widget.weatherData.location!,
                        temperature: widget.weatherData.temperature!,
                        suggestion: checkWeatherConditionsEnglish(
                            widget.weatherData.status!,
                            widget.weatherData.temperature!,
                            widget.weatherData.humidity! * 1.0,
                            widget.weatherData.windSpeed!,
                            5),
                        timeOfRain: widget.weatherData.timeOfRain!,
                        humidity: widget.weatherData.humidity ?? 0)
                    : const SizedBox(
                        height: 140,
                        child: Center(
                          child: Loader(),
                        ),
                      ),
                Container(
                  width: MediaQuery.of(context).size.width * ratio,
                  height: 120,
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    textDirection: lang == Langauge.arabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      Text(
                        lang == Langauge.arabic ? "الطقس" : "Weather",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        widget.weatherData.temperature != null
                            ? lang == Langauge.arabic
                                ? checkWeatherConditions(
                                    widget.weatherData.status!,
                                    widget.weatherData.temperature!,
                                    widget.weatherData.humidity! * 1.0,
                                    widget.weatherData.windSpeed!,
                                    5)
                                : checkWeatherConditionsEnglish(
                                    widget.weatherData.status!,
                                    widget.weatherData.temperature!,
                                    widget.weatherData.humidity! * 1.0,
                                    widget.weatherData.windSpeed!,
                                    5)
                            : "Fetching the current Location...",
                        style: const TextStyle(
                            color: Color(0xff465165), fontSize: 12),
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
                      textDirection: lang == Langauge.arabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      children: [
                        Text(
                            lang == Langauge.arabic
                                ? "اختار النبات"
                                : "Choose Your Plant",
                            style: const TextStyle(
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
                      textDirection: lang == Langauge.arabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      children: [
                        Text(
                            lang == Langauge.arabic
                                ? dbPlantsAr[state.selectedPlant].name
                                : dbPlants[state.selectedPlant].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Button(
                          text: lang == Langauge.arabic
                              ? "حساب الاسمده"
                              : "Calculate Fertilizer",
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
                              textDirection: lang == Langauge.arabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                Text(
                                  lang == Langauge.arabic
                                      ? "معلومات"
                                      : "About Plant",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    textDirection: lang == Langauge.arabic
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    // "They typically grow best in late spring, summer, and early fall in most climates.",
                                    lang == Langauge.arabic
                                        ? dbPlantsAr[state.selectedPlant]
                                            .description
                                        : dbPlants[state.selectedPlant]
                                            .description,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff465165))),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Button(text: "Read more", onPressed: () {})
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
