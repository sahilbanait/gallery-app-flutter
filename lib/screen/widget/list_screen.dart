import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;

import '../providers/ImagesList.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  File? _pickedImage;

  Future<void> _takePicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageFile = await saveImagePermantely(image.path);
    setState(() {
      this._pickedImage = imageFile;
    });
  }
  Future<File> saveImagePermantely(String imgpath) async {
    final dir = await syspath.getApplicationDocumentsDirectory();
    final name = path.basename(imgpath);
    final image = File('${dir.path}/$name');

    return File(imgpath).copy(image.path);
  }


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
    return Scaffold(
        body: Center(
      child: GridView.builder(

          primary: false,
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return index == 0
                ? Center(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _takePicture,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_pickedImage!),
                            fit: BoxFit.cover)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: listPopMenu(),
                          right: 0,
                        ),
                        Positioned(
                          child: listFavButton(),
                          bottom: 0,
                          right: 0,
                        )
                      ],
                    ),
                  );
          }),
    ));
  }



Widget listPopMenu() {
  return PopupMenuButton(
      color: Color(0xFF29292B),
      enabled: true,
      onSelected: (value) {},
      itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    ),
                    Text(
                      'Share',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    ),
                    Text('Rename', style: TextStyle(color: Colors.white))
                  ],
                )),
            PopupMenuItem(
                value: 3,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    ),
                    Text('Remove', style: TextStyle(color: Colors.white))
                  ],
                )),
          ]);
}

Widget listFavButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.favorite_border_outlined),
    color: Color(0xFF6200EE),
  );
}
