import 'package:flutter/material.dart';

class ImagePopMenu extends StatefulWidget {
  const ImagePopMenu({Key? key}) : super(key: key);

  @override
  State<ImagePopMenu> createState() => _ImagePopMenuState();
}

class _ImagePopMenuState extends State<ImagePopMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Color(0xFF29292B),
        enabled: true,
        onSelected: (value) {
          if (value == 3) {}
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
