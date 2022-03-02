import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_scene_recognizer/models/image_with_labels.dart';

class FireStoreService {
  Future<void> uploadImageWithLabel(
      ImageWithLabels imageWithLabels, User user) async {
    final imageWithLabelsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('images')
        .withConverter<ImageWithLabels>(
          fromFirestore: (snapshot, _) =>
              ImageWithLabels.fromJson(snapshot.data()!),
          toFirestore: (imageWithLabels, _) => imageWithLabels.toJson(),
        );
    await imageWithLabelsRef.add(imageWithLabels);
  }

  Future<void> deleteImageWithLabel(DocumentReference documentReference) {
    return documentReference
        .delete()
        .then((value) => print("Image with labels Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<List<ImageWithLabels>> getAllImageWithLabels(User user) async {
    final imageWithLabelsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('images')
        .withConverter<ImageWithLabels>(
          fromFirestore: (snapshot, _) =>
              ImageWithLabels.fromJson(snapshot.data()!),
          toFirestore: (imageWithLabels, _) => imageWithLabels.toJson(),
        );
    var results = await imageWithLabelsRef.get();
    var returnList = results.docs.map((doc) => doc.data()).toList();
    return returnList;
  }
}
