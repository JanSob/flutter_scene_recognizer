import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene_recognizer/models/image_with_labels.dart';
import 'package:flutter_scene_recognizer/routes/router.gr.dart';

class GalleryGridViewTile extends StatelessWidget {
  const GalleryGridViewTile(
      {Key? key,
      required this.cloudImage,
      required this.tileIndex,
      required this.imageWithLabel})
      : super(key: key);
  final ImageWithLabels imageWithLabel;
  final ImageProvider cloudImage;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          /* context.router
              .push(GalleryDetails(detailsImageUrl: imageWithLabel.imageUrl, snapshot: null)); */
        },
        child: GridTile(
          footer: Center(
              child: Text(
            imageWithLabel.labels.first,
            style: const TextStyle(color: Colors.red),
          )),
          child: Hero(
              tag: "cloudImage" + tileIndex.toString(),
              child: CachedNetworkImage(
                imageUrl: imageWithLabel.imageUrl,
              ) /* Image(
              image: cloudImage,
              fit: BoxFit.cover,
            ), */
              ),
        ),
      ),
    );
  }
}
