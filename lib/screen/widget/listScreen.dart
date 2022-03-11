import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/enums.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:gallery_app/screen/widget/imageDetailScreen.dart';
import 'package:gallery_app/screen/widget/imagePopMenu.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import '../../model/image_model.dart';

class ListScreen extends StatefulWidget {
  static const routName = '/list-screen';
  int count = 3;

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  void changeGrid() {
    setState(() {
      paginatorGlobalKey.currentState?.changeState(
          listType: ListType.GRID_VIEW,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6));
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance.currentUser;
  int? index;

  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    final imageData = Provider.of<Images>(context, listen: true);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: 300,
            height: 60,
            child: TextField(
              cursorColor: Colors.deepPurple,
              decoration: InputDecoration(
                  iconColor: Colors.deepPurple,
                  suffix: Icon(Icons.search),
                  labelText: 'Search',
                  fillColor: Colors.deepPurple,
                  focusColor: Colors.deepPurple,
                  suffixIconColor: Colors.deepPurple,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
            ),
          ),
        ),
        Expanded(
            child: Center(
                child: StreamBuilder(
                    stream: imageData.getFirebaseImages(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return GridView.builder(
                          key: paginatorGlobalKey,
                          itemCount: snapshot.data!.docs.length,
                          primary: false,
                          padding: EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemBuilder: (context, int index) {
                            String url =
                                snapshot.data!.docs[index]['downloadURL'];
                            // final images = Provider.of<Images>(context);
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ImageDetail.routName,
                                      arguments: url);
                                },
                                child: Consumer<Images>(
                                    builder: (context, images, child) =>
                                        GridTile(
                                            child: Image.network(
                                              url,
                                              fit: BoxFit.fitWidth,
                                              loadingBuilder: (context,
                                                  Widget child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                            footer: GridTileBar(
                                                title: Stack(
                                              children: [
                                                Positioned(
                                                  right: -14,
                                                  child: IconButton(
                                                      icon: Icon(
                                                        imageData.isFavourite
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      onPressed: () {
                                                        imageData
                                                            .toggleFavoriteStatus();
                                                      }),
                                                )
                                              ],
                                            )),
                                            header: GridTileBar(
                                                title: Stack(
                                              children: [
                                                Positioned(
                                                  right: -20,
                                                  child: ImagePopMenu(),
                                                ),
                                              ],
                                            )))));
                          },
                        );
                      }
                    })))
      ],
    ));
  }
}
