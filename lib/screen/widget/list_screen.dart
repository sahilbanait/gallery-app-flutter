import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_app/screen/providers/image_provider.dart';
import 'package:gallery_app/screen/widget/image_grid.dart';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:provider/provider.dart';

import '../model/image_model.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {


  // Future uploadFile() async {
  //   for (var img in _pickedImage) {
  //     reference = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('images/${Path.basename(img.path)}');
  //     await reference.p
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final imageData = Provider.of<ImageList>(context);
    final image = imageData.images;
    return Scaffold(
        body: Center(
      child: GridView.builder(
          itemCount: image.length,
          primary: false,
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return  ImageGrid(image[index].image);
          }),
    ));
  }


  Widget listFavButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.favorite_border_outlined),
      color: Color(0xFF6200EE),
    );
  }
}
