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
    print("this worked..?");
    return returnList;
  }

/*   Future<List<Object>?> getAllImageWithLabels(User user) async {
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('images');

    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await _collectionRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data());

    return null;
  } */
}
