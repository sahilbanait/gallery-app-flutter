import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Images with ChangeNotifier {
  final String image;
  bool isFavourite;
  Images({required this.image, this.isFavourite = false});

  void toggleFavoriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}

class ImageDate {
  final DateTime dateTime;
  ImageDate({required this.dateTime});
}
