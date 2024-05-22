import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:plantie/models/disease.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

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
  var class_names = [
    'Apple Apple scab',
    'Apple Black rot',
    'Apple Cedar apple rust',
    'Apple healthy',
    'Bean angular leaf spot',
    'Bean healthy',
    'Bean rust',
    'Corn Cercospora leaf spot Gray leaf spot',
    'Corn Common rust',
    'Corn Northern Leaf Blight',
    'Corn healthy',
    'Cucumber Anthracnose',
    'Cucumber Gummy Stem Blight',
    'Cucumber healthy',
    'Grape Black rot',
    'Grape Esca (Black Measles)',
    'Grape Leaf blight (Isariopsis Leaf Spot)',
    'Grape healthy',
    'Pepper bell Bacterial spot',
    'Pepper bell healthy',
    'Potato Early blight',
    'Potato Late blight',
    'Potato healthy',
    'Strawberry Leaf scorch',
    'Strawberry healthy',
    'Tomato Bacterial spot',
    'Tomato Early blight',
    'Tomato Late blight',
    'Tomato Leaf Mold',
    'Tomato Septoria leaf spot',
    'Tomato Spider mites Two-spotted spider mite',
    'Tomato Target Spot',
    'Tomato Tomato mosaic virus',
    'Tomato healthy',
    'olive aculus olearius',
    'olive healthy',
    'olive peacock spot'
  ];
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
        index = maxIndex > dbDiseasesAR.length ? 1 : maxIndex;
        detectedPlant =
            maxProbability >= 0.75 ? class_names[maxIndex] : "Unknown";
      });
    }).catchError((err) {});
  }

  @override
  void initState() {
    super.initState();
    predict();
  }

  Langauge lang = Langauge.arabic;

  @override
  Widget build(BuildContext context) {
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
                          // detectedPlant.toString(),
                          dbDiseasesAR[index].name,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: dbDiseasesAR[index].name.length > 15
                                  ? 14
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
                          onPressed: () {}),
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
              : Center(
                  child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Text(
                        dbDiseasesEN[0].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: detectedPlant.length > 15 ? 14 : 18.0,
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
                        child: const Text('About',
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
                        dbDiseasesEN[0].description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Color(0xff465165)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                        text: "Find the Treatment",
                        width: MediaQuery.of(context).size.width * 0.7,
                        onPressed: () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: const Text('Tips & Treat',
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
                      child: const Text(
                        'Apply a fungicide when environmental conditions are favorable and the first sign of disease becomes apparent',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Color(0xff465165)),
                      ),
                    ),
                  ],
                ))
          : const Center(
              child: Text('Unkonwn'),
            ),
    );
  }
}
