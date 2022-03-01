import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  ImageInput(this.imagePickFn);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImageInput> {
  var _pickedImage;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

      ),
    );
  }
}
