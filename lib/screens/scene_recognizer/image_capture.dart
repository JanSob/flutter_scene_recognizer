import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scene_recognizer/services/firestoreage_service.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../services/ai_recognition_service.dart';
import '../../services/auth_service.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({Key? key}) : super(key: key);
  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  final AiRecognitionService _aiRecognitionService = AiRecognitionService();
  bool isLoggingOut = false;
  bool _imageIsCropped = false;
  bool _predictionSuccess = false;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  List<dynamic>? predictionList;
  String fireStorePath = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '1. Please take/pick a photo from camera or local gallery',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: const Text('Camera'),
                    onPressed: () async {
                      _pickImage(ImageSource.camera);
                    }),
                const SizedBox(width: 20.0),
                ElevatedButton(
                    child: const Text('Gallery'),
                    onPressed: () async {
                      _pickImage(ImageSource.gallery);
                    }),
              ],
            ),
          ),
          if (_imageFile != null)
            Image.file(
              _imageFile!,
              width: 224,
              height: 224,
            ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                '2. Please crop your image in preperation of AI-analysis',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
              child: const Text('Crop'),
              onPressed: _imageFile != null
                  ? () async {
                      _cropImage();
                    }
                  : null),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('3. Click the AI-analyze button',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          ElevatedButton(
              child: const Text('AI-analyze'),
              onPressed: _imageIsCropped
                  ? () async {
                      List<dynamic>? resultList = await _aiRecognitionService
                          .recognizeImage(_imageFile!);
                      setState(() {
                        if (resultList != null) {
                          predictionList = resultList;
                          _predictionSuccess = true;
                        }
                      });
                    }
                  : null),
          if (_predictionSuccess)
            for (ImageLabel label in predictionList!)
              if (label.confidence > 0.74)
                Center(
                  child: Text(label.label +
                      " (confidence: " +
                      ((label.confidence * 100).round() == 100
                              ? 99
                              : (label.confidence * 100).round())
                          .toString() +
                      "%)"),
                ),
          //if (_predictionSuccess)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '4. You can upload the Image and the results to your firestore-gallery' +
                    fireStorePath,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
              onPressed: _predictionSuccess ? uploadFile : null,
              child: const Center(child: Text('Upload to Firebase')))
        ]);
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? selectedImage = await _picker.pickImage(source: source);
    setState(() {
      if (selectedImage != null) {
        _imageIsCropped = false;
        _predictionSuccess = false;
        _imageFile = File(selectedImage.path);
      }
    });
  }

  Future<void> _cropImage() async {
    if (_imageFile != null) {
      var _imageCropper = ImageCropper();
      File? cropped = await _imageCropper.cropImage(
          sourcePath: _imageFile!.path,
          maxHeight: 224,
          maxWidth: 224,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

      setState(() {
        _imageFile = cropped ?? _imageFile;
        _imageIsCropped = true;
      });
    }
  }

  Future uploadFile() async {
    if (_imageFile == null) return;
    final fileName = _imageFile!.path;
    final destination = 'files/' + predictionList![0].toString();
    fireStorePath = destination;
    // TODO: Spinner
    await FireStoreageService().uploadFile(
        fileName,
        context.read<User>(),
        List<String>.generate(
            predictionList!.length,
            (index) => (predictionList![index] as ImageLabel)
                .label)); //;(predictionList![0] as ImageLabel).label);
  }
}
