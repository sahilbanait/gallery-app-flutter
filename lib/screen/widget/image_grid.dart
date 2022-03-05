import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/image_model.dart';
import '../../model/image_provider.dart';

class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Provider.of<Images>(context);
    return GridTile(
        child: GestureDetector(
          child: Image.network(
            image.image,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
                image.isFavourite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              image.toggleFavoriteStatus();
            },
          ),
        ),
        header: GridTileBar(
          leading: listPopMenu(),
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
