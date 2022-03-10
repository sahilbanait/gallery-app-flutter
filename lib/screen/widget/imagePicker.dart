import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  String? downloadURL;

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
        final postID = DateTime.now().millisecondsSinceEpoch.toString();
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('${user?.uid}')
            .child('post_$postID');
        await ref.putFile(imageFile);
        downloadURL = await ref.getDownloadURL();
        await firebaseFirestore.collection('users').doc(user?.uid).collection('images').add({'downloadURL': downloadURL});

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
