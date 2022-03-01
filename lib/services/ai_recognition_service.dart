import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class AiRecognitionService {
  final _imageLabeler = GoogleMlKit.vision.imageLabeler();

  Future predictImage(File image) async {}

  Future<List?> recognizeImage(File file) async {
    final inputImage = InputImage.fromFile(file);
    final List<ImageLabel> resultLabels =
        await _imageLabeler.processImage(inputImage);
    _imageLabeler.close();
    return resultLabels;
  }
}
