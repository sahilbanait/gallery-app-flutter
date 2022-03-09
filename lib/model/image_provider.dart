import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'image_model.dart';

class ImageList with ChangeNotifier {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<Images> _images = [];
  List<Images> get images => [..._images];

  ImageList() {
    loadImages();
    notifyListeners();
  }

  Images findById(String image) {
    return _images.firstWhere((img) => img.image == image);
  }

  Future<List<Map<String, dynamic>>> loadImages() async {
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
            fileMeta.customMetadata?['description'] ?? 'No description',
        "uploaded_date": fileMeta.customMetadata?['']
      });
    });
    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> delete(String ref) async {
    await storage.ref(ref).delete();
  }
}
