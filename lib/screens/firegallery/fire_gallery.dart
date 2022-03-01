import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene_recognizer/models/image_with_labels.dart';
import 'package:flutter_scene_recognizer/services/firestore_service.dart';
import 'package:flutter_scene_recognizer/widgets/gallery_gridview_tile.dart';
import 'package:provider/provider.dart';

class FireGallery extends StatefulWidget {
  const FireGallery({Key? key}) : super(key: key);

  @override
  _FireGalleryState createState() => _FireGalleryState();
}

class _FireGalleryState extends State<FireGallery> {
  late List<Object?> imageWithLabels;
  bool _isLoading = true;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadData();
    });
  }

  Future<void> loadData() async {
    var results =
        await FireStoreService().getAllImageWithLabels(context.read<User>());
    //print(imageWithLabels.toString());
    //imageWithLabels = results.toList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          children: true
              ? [const Center(child: Text("Loading.."))]
              : [] /* [
                  for (int i = 0; i < imageWithLabels.length; i++)
                    GalleryGridViewTile(
                        cloudImage:
                            const AssetImage('assets/images/eso1907a.png'),
                        tileIndex: i,
                        imageWithLabel: ImageWithLabels(
                            imageUrl: imageWithLabels, labels: labels))
                ] */
          ),
    );
  }
}
