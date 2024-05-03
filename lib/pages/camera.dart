import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
  // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text('Camera Picker Page'),
        ),
      ],
    );
  }
}
