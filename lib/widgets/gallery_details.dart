import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene_recognizer/services/firestore_service.dart';
import 'package:flutter_scene_recognizer/services/firestoreage_service.dart';

class GalleryDetails extends StatelessWidget {
  const GalleryDetails(
      {Key? key, required this.detailsImageUrl, required this.snapshot})
      : super(key: key);
  final String detailsImageUrl;
  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;

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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
              tag: detailsImageUrl,
              child: CachedNetworkImage(
                imageUrl: snapshot.data()['imageUrl'],
                fit: BoxFit.contain,
              )),
          ElevatedButton(
              onPressed: () async {
                await FireStoreService()
                    .deleteImageWithLabel(snapshot.reference);
                await FireStoreageService()
                    .deleteImage(snapshot.data()['imageUrl']);
                Navigator.pop(context);
              },
              child: const Text("Delete"),
              style: ElevatedButton.styleFrom(primary: Colors.red))
        ],
      )),
    );
  }
}
