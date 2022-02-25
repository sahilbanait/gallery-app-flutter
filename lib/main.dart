import 'package:Gallery/screen/homepage/HomePage.dart';
import 'package:Gallery/screen/authentication/Login.dart';
import 'package:Gallery/screen/homepage/wrapper.dart';
import 'package:flutter/material.dart';

void main() => runApp(GalleryApp());

class GalleryApp extends StatelessWidget {
  const GalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      title: "Gallery App",
    );
  }
}
