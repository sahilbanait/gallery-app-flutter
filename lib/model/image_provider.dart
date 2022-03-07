import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'image_model.dart';

class ImageList with ChangeNotifier {
  FirebaseStorage storage = FirebaseStorage.instance;
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

  Future<List<Map<String, dynamic>>> loadImages(BuildContext context) async {
    List<Map<String, dynamic>> files = [];
    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }
}
