import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SpinKitFadingCircle(
      color: Color(0xff47B88A),
      size: 30,
    ));
  }
}
