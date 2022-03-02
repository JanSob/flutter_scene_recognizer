import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

import '../../routes/router.gr.dart';

class FlutterFireGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final usersQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<User>().uid)
        .collection('images');

    return FirestoreListView<Map<String, dynamic>>(
      shrinkWrap: true,
      query: usersQuery,
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> image = snapshot.data();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              context.router.push(GalleryDetails(
                  detailsImageUrl: image['imageUrl'], snapshot: snapshot));
            },
            onDoubleTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CachedNetworkImage(imageUrl: image['imageUrl']),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child:
                                          const Center(child: Text('Chancel'))),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {},
                                      child:
                                          const Center(child: Text('Delete'))),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            child: Card(
                child: Column(
              children: [
                Hero(
                    tag: image['imageUrl'],
                    child: CachedNetworkImage(imageUrl: image['imageUrl'])),
                for (int i = 0; i < 3 && i < (image['labels']).length; i++)
                  Text(
                    image['labels'][i].toString(),
                  )
              ],
            )),
          ),
        );

        //return Text('User name is ${image.keys}');
      },
    );
  }
}
