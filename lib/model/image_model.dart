import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Images with ChangeNotifier {
 String? image;
  bool isFavourite;
  Images({this.image,this.isFavourite = false});

  // User? user => FirebaseAuth.instance.currentUser;

  void toggleFavoriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

 // getFirebaseImages(){
 //   FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('images').snapshots();
 // }
}

