
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imagePath),
        ),
      ),
    );
  }
}