import 'package:flutter/material.dart';

class GalleryDetails extends StatelessWidget {
  const GalleryDetails(
      {Key? key, required this.detailsImage, required this.detailsIndex})
      : super(key: key);
  final ImageProvider detailsImage;
  final int detailsIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Hero(
              tag: "cloudImage" + detailsIndex.toString(),
              child: Image(image: detailsImage, fit: BoxFit.contain))),
    );
  }
}
