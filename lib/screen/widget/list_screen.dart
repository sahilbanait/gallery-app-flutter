import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:gallery_app/screen/widget/image_grid.dart';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:provider/provider.dart';
import '../../model/image_model.dart';
import '../../model/image_provider.dart';

class ListScreen extends StatefulWidget {
  static const routName = '/list-screen';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    final imageData = Provider.of<ImageList>(context,listen: true);
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: imageData.addImage(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      primary: false,
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 4,
                          crossAxisCount: 4,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        final  Map<String, dynamic> image =
                            snapshot.data![index];
                        return GridTile(
                            child: GestureDetector(
                              child: Image.network(
                                image['url'],
                                fit: BoxFit.cover,

                              ),
                            ),
                            footer: GridTileBar(
                                // leading: IconButton(
                                //   icon: Icon(images.isFavourite
                                //       ? Icons.favorite
                                //       : Icons.favorite_border),
                                //   onPressed: () {
                                //     images.toggleFavoriteStatus();
                                //   },
                                // ),
                                ),
                            header: GridTileBar(
                              leading: listPopMenu(),
                            ));
                      },
                    );
                  }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    return CircularProgressIndicator();
                })));
  }

  Widget listPopMenu() {
    return PopupMenuButton(
        color: Color(0xFF29292B),
        enabled: true,
        onSelected: (value) {
          if (value == 3) {

          }
        },
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
}

