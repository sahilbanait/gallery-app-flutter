import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // File _pickedImage;
  List<File> _pickedImage = [];
  final _picker = ImagePicker();

  // void _selectImage(File pickedImage) {
  //   _pickedImage = pickedImage;
  // }

  Future<void> _takePicture() async {
    final pickedImage = await _picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile as List<File>;
    });
    final appDir = await PathProvider.getApplicationDocumentsDirectory();
    final fileName = Path.basename(pickedImageFile.path);
    final savedImage = await pickedImageFile.copy('${appDir.path}/$fileName');
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
          itemCount: _pickedImage.length + 1,
          primary: false,
          padding: const EdgeInsets.all(16),
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
                    margin: EdgeInsets.all(3),
                    color: Colors.grey,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_pickedImage[-1]),
                    )),
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
