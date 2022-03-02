import 'dart:io';

import 'package:flutter/material.dart';
import '../model/image_model.dart';

class ImageList with ChangeNotifier {
  List<Images> _images = [];
  List<Images> get images => [..._images];

  void addImage() {
    notifyListeners();
  }
  Images findById(File image){
    return _images.firstWhere((img) => img.image == image);
  }
}
