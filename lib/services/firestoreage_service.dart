import 'dart:io';
import 'package:flutter_scene_recognizer/models/image_with_labels.dart';
import 'package:flutter_scene_recognizer/services/firestore_service.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'auth_service.dart';

class FireStoreageService {
  Future<void> uploadFile(
      String filePath, User user, List<String> labels) async {
    print(user.uid.toString());
    File file = File(filePath);
    final String destinationPath = "users/" +
        user.uid +
        "/" +
        labels.first +
        "_" +
        DateTime.now().toString() +
        "_" +
        "." +
        filePath.split('.').last;
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(destinationPath)
          .putFile(file);
      //get link
      String imageUrlRef = await firebase_storage.FirebaseStorage.instance
          .ref(destinationPath)
          .getDownloadURL();
      FireStoreService().uploadImageWithLabel(
          ImageWithLabels(imageUrl: imageUrlRef, labels: labels), user);
    } catch (e) {
      print(e);
    }
  }
}
