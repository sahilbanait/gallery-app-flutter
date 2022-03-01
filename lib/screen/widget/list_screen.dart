import 'package:flutter/material.dart';
import 'package:gallery_app/screen/homepage/homepage.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(50, (index) {
          return Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey,
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
      )),
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

Widget listFavButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.favorite_border_outlined),
    color: Color(0xFF6200EE),
  );
}
