import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:plantie/models/disease.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math; // Import the math library

enum Langauge { english, arabic }

class CameraResult extends StatefulWidget {
  const CameraResult({super.key, required this.path});
  final String path;

  @override
  State<CameraResult> createState() => _CameraResultState();
}

class _CameraResultState extends State<CameraResult> {
  bool predicted = true;
  String detectedPlant = '';
  late Uint8List _preprocessedImageBytes;
  // ignore: non_constant_identifier_names

  int index = 0;
  img.Image clipImage(img.Image image, int targetWidth, int targetHeight) {
    int width = image.width;
    int height = image.height;
    int startX = (width - targetWidth) ~/ 2;
    int startY = (height - targetHeight) ~/ 2;

    return img.copyCrop(image, startX, startY, targetWidth, targetHeight);
  }

  Float32List preprocessImage(Uint8List imageBytes) {
    img.Image image = img.decodeImage(imageBytes)!;
    int targetWidth = (image.width).round();
    int targetHeight = (image.width).round();
    img.Image clippedImage = clipImage(image, targetWidth, targetHeight);
    img.Image normalizedImage = img.normalize(clippedImage, 10, 230);
    img.Image resizedImage =
        img.copyResize(normalizedImage, width: 224, height: 224);
    _preprocessedImageBytes = Uint8List.fromList(img.encodePng(resizedImage));
    Float32List input = Float32List(1 * 224 * 224 * 3);
    int bufferIndex = 0;
    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        int pixel = resizedImage.getPixel(x, y);
        input[bufferIndex++] = img.getRed(pixel) / 255.0;
        input[bufferIndex++] = img.getGreen(pixel) / 255.0;
        input[bufferIndex++] = img.getBlue(pixel) / 255.0;
      }
    }

    return input;
  }

  void predict() {
    Interpreter.fromAsset('assets/ml/model_mobilenetv2.tflite')
        .then((interpreter) {
      // Read image file and preprocess it
      Uint8List imageBytes = File(widget.path).readAsBytesSync();
      Float32List input = preprocessImage(imageBytes);
      // Define the output buffer with the shape [1, 37]
      var output = List.generate(1, (_) => List.filled(37, 0.0));
      // Run the model
      interpreter.run(input.buffer.asUint8List(), output);
      List<double> probabilities = output[0];
      double maxProbability = probabilities.reduce((a, b) => a > b ? a : b);
      int maxIndex = probabilities.indexOf(maxProbability);
      setState(() {
        index = maxIndex > dbDiseasesEN.length ? 1 : maxIndex;
      });
    }).catchError((err) {});
  }

//  Map Part
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> openMap(double currentLatitude, double currentLongitude,
      destinationLatitude, destinationLongitude) async {
    const url = 'https://www.google.com/maps?dir=d';
    final origin = '&saddr=$currentLatitude,$currentLongitude';
    final destination = '&daddr=$destinationLatitude,$destinationLongitude';

    final completeUrl = Uri.parse(url + origin + destination);

    if (await canLaunchUrl(completeUrl)) {
      await launchUrl(completeUrl);
    } else {
      throw 'Could not launch Google Maps.';
    }
  }

  final destinations = [
    {'latitude': 32.457871368616054, 'longitude': 35.295419643721054},
    {'latitude': 32.521995409556375, 'longitude': 35.31512951071361},
  ];
  Future<void> launchMapForNearest(
      List<Map<String, double>> destinations) async {
    final currentLocation = await _determinePosition();
    final currentLatitude = currentLocation.latitude;
    final currentLongitude = currentLocation.longitude;

    final distances = destinations.map((destination) {
      final destinationLatitude = destination['latitude'];
      final destinationLongitude = destination['longitude'];
      return Geolocator.distanceBetween(currentLatitude, currentLongitude,
          destinationLatitude!, destinationLongitude!);
    }).toList();

    final nearestIndex =
        distances.indexOf(distances.reduce((a, b) => a > b ? b : a));

    final nearestDestination = destinations[nearestIndex];
    final nearestLatitude = nearestDestination['latitude'];
    final nearestLongitude = nearestDestination['longitude'];
    await openMap(
        currentLatitude, currentLongitude, nearestLatitude, nearestLongitude);
  }

  @override
  void initState() {
    super.initState();
    predict();
  }

  Langauge lang = Langauge.arabic;

  @override
  Widget build(BuildContext context) {
    if (dbDiseasesEN[index].isHealthy) {
      var lst = lang == Langauge.arabic
          ? dbDiseasesAR.where((e) =>
              e.name.endsWith(dbDiseasesAR[index].name.split(" ")[0]) &&
              e.name != dbDiseasesAR[index].name)
          : dbDiseasesEN.where((e) =>
              e.name.startsWith(dbDiseasesEN[index].name.split(" ")[0]) &&
              e.name != dbDiseasesEN[index].name);
      return Scaffold(
          appBar: AppBar(),
          body: _preprocessedImageBytes.isNotEmpty
              ? Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lang == Langauge.arabic
                                ? dbDiseasesAR[index].name
                                : dbDiseasesEN[index].name,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff47B88A)),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: lang == Langauge.arabic
                                ? const Text(
                                    "اشهر امراض النبات",
                                    textDirection: TextDirection.rtl,
                                  )
                                : const Text("Plant's Popular Diseases"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 160,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: lst
                                    .map((e) => Container(
                                        width: 200,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/test.png"),
                                                fit: BoxFit.cover)),
                                        child: Center(
                                            child: Text(
                                          e.name.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ))))
                                    .toList(),
                              ))
                        ],
                      )))
              : const Center(
                  child: CircularProgressIndicator(),
                ));
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: _preprocessedImageBytes.isNotEmpty && detectedPlant != 'Unknown'
            ? lang == Langauge.arabic
                ? SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Text(
                            dbDiseasesAR[index].name,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: dbDiseasesAR[index].name.length > 20
                                    ? 16
                                    : 18.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff47B88A)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 160,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset('assets/images/test.png'),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset('assets/images/test.png'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: const Text('عن المرض',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff47B88A)))),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Text(
                            dbDiseasesAR[index].description,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(color: Color(0xff465165)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                const Text('العلاج',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff47B88A))),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "المبيد الحشري ${dbDiseasesAR[index].medicine}",
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                            text: "اوجد العلاج على الخريطه",
                            width: MediaQuery.of(context).size.width * 0.7,
                            onPressed: () {
                              launchMapForNearest(destinations)
                                  .then((onValue) {})
                                  .catchError((onError) {});
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: const Text('النصائح',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff47B88A)))),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Column(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dbDiseasesAR[index].tips.map((e) {
                                return Text(
                                  '•  ${e.toString()}',
                                  textAlign: TextAlign.justify,
                                  textDirection: TextDirection.rtl,
                                  style:
                                      const TextStyle(color: Color(0xff465165)),
                                );
                              }).toList(),
                            )),
                      ],
                    )))
                : SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Text(
                            // detectedPlant.toString(),
                            dbDiseasesEN[index].name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: dbDiseasesEN[index].name.length > 20
                                    ? 16
                                    : 18.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff47B88A)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 160,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset('assets/images/test.png'),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset('assets/images/test.png'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: const Text("About",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff47B88A)))),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Text(
                            dbDiseasesEN[index].description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(color: Color(0xff465165)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Row(
                              children: [
                                const Text("Treatment",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff47B88A))),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  dbDiseasesEN[index].medicine,
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                            text: "Find the Treatment in the Map",
                            width: MediaQuery.of(context).size.width * 0.7,
                            onPressed: () {
                              launchMapForNearest(destinations)
                                  .then((onValue) {})
                                  .catchError((onError) {});
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: const Text('Tips',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff47B88A)))),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dbDiseasesEN[index].tips.map((e) {
                                return Text(
                                  '•  ${e.toString()}',
                                  textAlign: TextAlign.justify,
                                  style:
                                      const TextStyle(color: Color(0xff465165)),
                                );
                              }).toList(),
                            )),
                      ],
                    )))
            : Center(
                child: Text(lang == Langauge.arabic ? "غير معروف" : 'Unkonwn'),
              ),
      );
    }
  }
}
