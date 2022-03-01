import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImageInput extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImageInput> {
  Future<void> takePicture() async {
    final imageFile = await ImagePicker.platform.pickImage(source: ImageSource.camera,);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
