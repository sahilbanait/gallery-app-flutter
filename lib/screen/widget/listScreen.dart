import 'dart:io';
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
  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    final imageData = Provider.of<ImageList>(context, listen: true);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(10),
          child:  Container(
            width: 300,
            height: 60,
            child:  TextField(
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
                  )
              ),
            ),
          ),
        ),
        Expanded(
            child: Center(
                child: FutureBuilder(
                    future: imageData.loadImages(),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GridView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          primary: false,
                          padding: EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(

                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> image =
                                snapshot.data![index];
                            // final images = Provider.of<Images>(context);
                            return GridTile(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        ImageDetail.routName,
                                        arguments: image['url']);
                                  },
                                  child: Image.network(
                                    image['url'],
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, Widget child,
                                        loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
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
                                ),
                                footer: Card(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        GridTileBar(
                                          trailing: IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    )),
                                header: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      GridTileBar(
                                        leading: ImagePopMenu(),
                                      )
                                    ]));
                          },
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return CircularProgressIndicator();
                    })))
      ],
    ));
  }
}