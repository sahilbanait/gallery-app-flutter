import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/screen/widget/imageDetailScreen.dart';
import 'package:gallery_app/screen/widget/imagePopMenu.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import '../../model/image_model.dart';
import '../../model/image_provider.dart';

class ListScreen extends StatefulWidget {
  static const routName = '/list-screen';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance.currentUser;

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
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth!.uid)
                        .collection('images')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        // return (const
                        // Center(
                        //   child: Text('No images found'),
                        // )
                        // );
                        return CircularProgressIndicator();
                      } else {
                        return
                                GridView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  primary: false,
                                  padding: EdgeInsets.all(16),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5),
                                  itemBuilder: (context, int index) {
                                    String url = snapshot.data!.docs[index]
                                        ['downloadURL'];
                                    // final images = Provider.of<Images>(context);
                                    return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                ImageDetail.routName,
                                                arguments: url);
                                          },
                                          child: Consumer<Images>(
                                          builder: (context, images, child) => GridTile(
                                          child: Image.network(
                                            url,
                                            fit: BoxFit.fitWidth,
                                            loadingBuilder: (context,
                                                Widget child, loadingProgress) {
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

                                        footer: Card(
                                            color: Colors.transparent,
                                            elevation: 0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                GridTileBar(
                                                  trailing: IconButton(
                                                    icon: Icon(imageData.isFavourite
                                                        ? Icons.favorite
                                                        : Icons.favorite_border),
                                                    onPressed:
                                                    (){
                                                      imageData.toggleFavoriteStatus();
                                                    }
                                                  ),
                                                ),
                                              ],
                                            )),
                                        header: GridTileBar(
                                            title: Stack(
                                          children: [
                                            Positioned(
                                              right: 1,
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
