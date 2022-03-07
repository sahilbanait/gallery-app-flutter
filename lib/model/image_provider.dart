import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'image_model.dart';

class ImageList with ChangeNotifier {
  List<Images> _images = [
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
    Images(
        image:
            'https://cdn.pixabay.com/photo/2022/02/25/08/13/blood-oranges-7033738_960_720.jpg'),
  ];

  List<Images> get images => [..._images];

  void addImage() {
    notifyListeners();
  }

  Images findById(String image) {
    return _images.firstWhere((img) => img.image == image);
  }
}
