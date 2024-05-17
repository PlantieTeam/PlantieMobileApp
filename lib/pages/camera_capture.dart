import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantie/main.dart';
import 'package:plantie/pages/camera_result.dart';

class CameraCapture extends StatefulWidget {
  const CameraCapture({super.key});

  @override
  State<CameraCapture> createState() => _CameraCaptureState();
}

class _CameraCaptureState extends State<CameraCapture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File image = File('');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(firstCamera, ResolutionPreset.max);
    _initializeControllerFuture = _controller.initialize();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            // height: 100,
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      color: Colors.white,
                      onPressed: () {
                        try {
                          _controller.takePicture().then((e) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CameraResult(path: e.path)));
                          });
                          // print(image.length());
                        } catch (e) {}
                      },
                      icon: Icon(Icons.camera_alt),
                    )
                  ],
                ))),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Center(
                child: Transform.scale(
                    scale:
                        1 / (_controller.value.aspectRatio * size.aspectRatio),
                    alignment: Alignment.center,
                    child: CameraPreview(
                      _controller,
                      child: Center(
                          child: SvgPicture.asset(
                              "assets/images/capture_borders.svg",
                              width: 150)),
                    )),
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
