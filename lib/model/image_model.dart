import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Images with ChangeNotifier {
  String? image;
  User? user = FirebaseAuth.instance.currentUser;
  bool isFavourite;

  Images({this.image, this.isFavourite = false});

  //Set image as favourite
  void toggleFavoriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  //Retrieving images from firebase
  Stream<QuerySnapshot<Map<String, dynamic>>> getFirebaseImages() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('images')
        .snapshots();
  }
}
