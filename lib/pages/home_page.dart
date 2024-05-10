import 'package:flutter/material.dart';
import 'package:plantie/shared/custom_listView.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:plantie/shared/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  double ratio = 0.90;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WeatherCard(
                status: WeatherStatus.rainy,
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Weather Today is good for applying the fertilizers",
                    style: TextStyle(color: Color(0xff465165), fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * ratio,
                // height: 100,
                margin: const EdgeInsets.only(top: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Choose Your Plant",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                    CustomListView(),
                  ],
                )),
            Container(
                width: MediaQuery.of(context).size.width * ratio,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Tomato",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Button(
                      text: "Calculate Fertilizer",
                      onPressed: () {},
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width * ratio,
                      // height: 400,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffD9D9D9),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Growing season",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                                "They typically grow best in late spring, summer, and early fall in most climates.",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff465165))),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Water Need",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("1 inch of water per week",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff465165))),
                            const SizedBox(height: 20),
                            Button(text: "Read more", onPressed: () {})
                          ]),
                    )
                  ],
                )),
          ],
        )));
  }
}
