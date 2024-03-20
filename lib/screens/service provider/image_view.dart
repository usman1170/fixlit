import 'package:flutter/material.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.image});
  final String image;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.network(widget.image)),
    );
  }
}
