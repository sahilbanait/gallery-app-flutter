

import 'dart:ui';

import 'package:first_app/HomePage.dart';
import 'package:first_app/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginFormValidation(),
      title: "Gallery App",
    );
  }
}


