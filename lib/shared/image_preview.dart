import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  final bool local;
  const ImagePreviewScreen(
      {super.key, required this.imagePath, this.local = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: !local
            ? PhotoView(
                imageProvider: NetworkImage(imagePath),
              )
            : PhotoView(
                imageProvider: FileImage(File(imagePath)),
              ),
      ),
    );
  }
}
