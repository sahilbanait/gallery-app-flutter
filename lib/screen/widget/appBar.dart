import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApplicationToolbar extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppbarState createState() => _AppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppbarState extends State<ApplicationToolbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("GalleryApp"),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.grid_view)),
        IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.lock_outline)),
      ],
    );
  }
}
