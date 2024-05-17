import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:plantie/shared/custome_button.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CameraResult extends StatefulWidget {
  const CameraResult({super.key, required this.path});
  final String path;

  @override
  State<CameraResult> createState() => _CameraResultState();
}

class _CameraResultState extends State<CameraResult> {
  bool predicted = true;
  String detectedPlant = '';
  var class_names = [
    'Apple___Apple_scab',
    'Apple___Black_rot',
    'Apple___Cedar_apple_rust',
    'Apple___healthy',
    'Bean___angular_leaf_spot',
    'Bean___healthy',
    'Bean___rust',
    'Corn___Cercospora_leaf_spot Gray_leaf_spot',
    'Corn___Common_rust',
    'Corn___Northern_Leaf_Blight',
    'Corn___healthy',
    'Cucumber___Anthracnose',
    'Cucumber___Gummy Stem Blight',
    'Cucumber___healthy',
    'Grape___Black_rot',
    'Grape___Esca_(Black_Measles)',
    'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)',
    'Grape___healthy',
    'Pepper_bell___Bacterial_spot',
    'Pepper_bell___healthy',
    'Potato___Early_blight',
    'Potato___Late_blight',
    'Potato___healthy',
    'Strawberry___Leaf_scorch',
    'Strawberry___healthy',
    'Tomato___Bacterial_spot',
    'Tomato___Early_blight',
    'Tomato___Late_blight',
    'Tomato___Leaf_Mold',
    'Tomato___Septoria_leaf_spot',
    'Tomato___Spider_mites Two-spotted_spider_mite',
    'Tomato___Target_Spot',
    'Tomato___Tomato_mosaic_virus',
    'Tomato___healthy',
    'olive_aculus_olearius',
    'olive_healthy',
    'olive_peacock_spot'
  ];
  Float32List preprocessImage(Uint8List imageBytes) {
    // Decode the image
    img.Image image = img.decodeImage(imageBytes)!;

    // Resize the image to 224x224 (the expected input size for MobileNetV2)
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // Normalize the pixel values to [0, 1] and create a Float32List
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void predict() {
    Interpreter.fromAsset('assets/ml/model_mobilenetv2.tflite')
        .then((interpreter) {
      print('model Loaded');
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

      print('Max Probability: $maxProbability');
      print('Class Index: ${class_names[maxIndex]}');
      setState(() {
        // predicted = false;
        detectedPlant = class_names[maxIndex];
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: predicted
          ? Center(
              child: Column(
              children: [
                Button(
                    text: "Predict",
                    onPressed: () {
                      predict();
                    }),
                Image.file(
                  File(widget.path),
                ),
                Text('$detectedPlant')
              ],
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}