import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

enum WeatherStatus { partlyCloudy, sunny, cloudy, rainy }

const Map<WeatherStatus, List<Color>> colors = {
  WeatherStatus.partlyCloudy: [Color(0xff05159E), Color(0xff84D3FF)],
  WeatherStatus.sunny: [Color(0xffDA7211), Color(0xffFDF52F)],
  WeatherStatus.cloudy: [Color(0xff848CCF), Color(0xffB8BCE5)],
  WeatherStatus.rainy: [Color(0xff0539C0), Color(0xff5BC4FF)],
};

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    super.key,
    required this.status,
    required this.location,
    required this.temperature,
    required this.suggestion,
    required this.timeOfRain,
    required this.humidity,
  });
  final String status;
  final String location;
  final double temperature;
  final String timeOfRain;
  final String suggestion;
  final int humidity;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String img = 'weather_sunny.svg';
  WeatherStatus status = WeatherStatus.partlyCloudy;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.status) {
      case "Partly Cloudy":
        img = 'weather_partly_cloudy.svg';
        status = WeatherStatus.partlyCloudy;
        break;
      case "Clear":
        img = 'weather_sunny.svg';
        status = WeatherStatus.sunny;
        break;
      case "Cloudy":
        img = 'weather_cloudy.svg';
        status = WeatherStatus.cloudy;
        break;
      case "Rainy":
        img = 'weather_rainy.svg';
        status = WeatherStatus.rainy;
        break;
      default:
        img = 'weather_partly_cloudy.svg';
        status = WeatherStatus.partlyCloudy;
    }

    // JUST FOR TESTING
    status = WeatherStatus.partlyCloudy;
    img = 'weather_partly_cloudy.svg';
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: 183,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: colors[status]!)),
        child: Container(
            width: 370,
            height: 183,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: const LinearGradient(
                  begin: Alignment(-0.5, 0.5),
                  end: Alignment(0.5, 0.5),
                  colors: [Color(0x66D9D9D9), Color(0x00D9D9D9)]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.status,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset("assets/images/$img"),
                  ],
                ),
                const SizedBox(
                  height: 128,
                  child: VerticalDivider(
                    color: Color(0x63FFFFFF),
                    thickness: 1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.location,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text(DateFormat('EEEE').format(DateTime.now()),
                        style: const TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                        '${((widget.temperature - 32) * 5 / 9).toStringAsFixed(2)} °',
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text("${widget.temperature.toString()} F°",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                )
              ],
            )),
      ),
      back: Container(
        width: 370,
        height: 183,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: colors[status]!)),
        child: Container(
          width: 370,
          height: 183,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: const LinearGradient(
                begin: Alignment(-0.5, 0.5),
                end: Alignment(0.5, 0.5),
                colors: [Color(0x66D9D9D9), Color(0x00D9D9D9)]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.status,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('${widget.temperature.toString()}° F',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white)),
                      Text(
                        widget.location,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SvgPicture.asset("assets/images/$img"),
                ],
              ),
              const SizedBox(
                width: 338.77,
                child: Divider(
                  color: Color(0x63FFFFFF),
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.timeOfRain,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.suggestion.length > 30
                            ? widget.suggestion.substring(0, 30) + "..."
                            : widget.suggestion,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/weather_humidity.svg"),
                      Text(
                        widget.humidity.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
