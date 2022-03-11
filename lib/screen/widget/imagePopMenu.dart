import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePopMenu extends StatefulWidget {
  ImagePopMenu({Key? key}) : super(key: key);

  @override
  State<ImagePopMenu> createState() => _ImagePopMenuState();
}

class _ImagePopMenuState extends State<ImagePopMenu> {
  User? user = FirebaseAuth.instance.currentUser;
  final postID = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(
        color: Color(0xFF29292B),
        enabled: true,
        onSelected: (value) {
          if (value == 3) {
            setState(() {});
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
