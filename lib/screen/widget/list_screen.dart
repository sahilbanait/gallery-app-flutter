import 'dart:io';
import 'package:flutter/material.dart';

import 'package:gallery_app/screen/widget/image_grid.dart';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:provider/provider.dart';
import '../../model/image_provider.dart';

class ListScreen extends StatefulWidget {
  static const routName = '/list-screen';
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
              childAspectRatio: 3 / 4,
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: image[index],
                child: ImageGrid(),
              )),
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
}
