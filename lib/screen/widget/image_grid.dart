import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/screen/providers/image_provider.dart';
import 'package:provider/provider.dart';

class ImageGrid extends StatelessWidget {
  final File? image;

  ImageGrid(this.image);

  @override
  Widget build(BuildContext context) {
  final imageData = ModalRoute.of(context)?.settings.arguments as File;
  final imageList = Provider.of<ImageList>(context).findById(imageData);
    return GridTile(
        child: GestureDetector(
          child: Image.file(
            imageList.image,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          trailing: IconButton(
            icon: Icon(Icons.favorite_border_outlined),
            onPressed: () {},
          ),
        ),
      header: GridTileBar(
        trailing: listPopMenu(),
      ),
    );
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
