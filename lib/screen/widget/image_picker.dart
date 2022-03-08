import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget with ChangeNotifier {
  static const routName = '/image-picker';

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImageInput> {
  FirebaseStorage storage = FirebaseStorage.instance;

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage

  Future<void> upload(String inputSource) async {
    XFile? pickedImage;
    final picker = ImagePicker();
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final filename = path.basename(pickedImage.path);
      final savedImage = await imageFile.copy('${appDir.path}/$filename');

      try {
        // Uploading the selected image with some custom meta data
        // final ref = storage.ref('GalleryApp/Images/').child(fileName);
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(
                customMetadata: {'uploaded_by': '', 'uploaded_date': 'Date'}));
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: new Icon(Icons.camera),
        title: new Text('Camera'),
        onTap: () {
          upload('camera');
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: new Icon(Icons.library_add),
        title: new Text('Gallery'),
        onTap: () {
          upload('gallery');
          Navigator.pop(context);
        },
      ),
    ]);
  }
}
