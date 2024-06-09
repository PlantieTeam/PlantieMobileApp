import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(firstCamera, ResolutionPreset.max);
    _initializeControllerFuture = _controller.initialize();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ));
  }

  Future getImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) => CameraResult(path: image.path)));
    }
  }

  Future getImageFromCamera() async {
    ImagePicker picker = ImagePicker();
    setState(() {
      isLoading = true;
    });
    var image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      isLoading = false;
    });
    if (image != null) {
      Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) => CameraResult(path: image.path)));
    }
  }

  Future takePicture() async {
    try {
      setState(() {
        isLoading = true;
      });
      _controller.takePicture().then((e) {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CameraResult(path: e.path)));
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            // height: 100,
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        getImageFromGallery();
                      },
                      icon: const Icon(Icons.image_search),
                    ),
                    InkWell(
                        onTap: () {
                          takePicture();
                        },
                        child: const Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              size: 50,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.circle,
                              size: 30,
                              color: Colors.white,
                            ),
                          ],
                        )),
                    IconButton(
                        onPressed: () {
                          getImageFromCamera();
                        },
                        icon: const Icon(Icons.camera))
                  ],
                ))),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                isLoading == false) {
              return Center(
                  child: Stack(children: [
                Center(
                    child: CameraPreview(
                  _controller,
                )),
                // )),
                Center(
                    child: Image.asset(
                  scale: _controller.value.aspectRatio - 0.3,
                  "assets/images/capture_borders.png",
                ))
              ]));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}








// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:plantie/pages/camera_result.dart';

// class CameraCapture extends StatefulWidget {
//   const CameraCapture({super.key});

//   @override
//   State<CameraCapture> createState() => _CameraCaptureState();
// }

// class _CameraCaptureState extends State<CameraCapture> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(firstCamera, ResolutionPreset.max);
//     _initializeControllerFuture = _controller.initialize();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.black,
//     ));
//   }

//   Future<void> getImageFromGallery() async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedImage != null) {
//         if (!mounted) return;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CameraResult(path: pickedImage.path),
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle errors
//       print("Error picking image from gallery: $e");
//     }
//   }

//   Future<void> getImageFromCamera() async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       setState(() {
//         isLoading = true;
//       });
//       final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
//       setState(() {
//         isLoading = false;
//       });
//       if (pickedImage != null) {
//         if (!mounted) return;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CameraResult(path: pickedImage.path),
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle errors
//       print("Error picking image from camera: $e");
//     }
//   }

//   Future<void> takePicture() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       final XFile image = await _controller.takePicture();
//       setState(() {
//         isLoading = false;
//       });
//       if (!mounted) return;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CameraResult(path: image.path),
//         ),
//       );
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print("Error taking picture: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.white,
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.black,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: getImageFromGallery,
//                 icon: const Icon(Icons.image_search),
//               ),
//               InkWell(
//                 onTap: takePicture,
//                 child: const Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Icon(
//                       Icons.circle_outlined,
//                       size: 50,
//                       color: Colors.white,
//                     ),
//                     Icon(
//                       Icons.circle,
//                       size: 30,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 onPressed: getImageFromCamera,
//                 icon: const Icon(Icons.camera),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done && !isLoading) {
//             return Center(
//               child: Stack(
//                 children: [
//                   Center(
//                     child: CameraPreview(_controller),
//                   ),
//                   Center(
//                     child: Image.asset(
//                       "assets/images/capture_borders.png",
//                       scale: _controller.value.aspectRatio - 0.3,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

