import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/enums.dart';
import 'package:flutter_paginator/flutter_paginator.dart';

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  final GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  void _changeGrid() {
    paginatorGlobalKey.currentState?.changeState(
        listType: ListType.GRID_VIEW,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("GalleryApp"),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: <Widget>[
        IconButton(
            onPressed: () {
              _changeGrid();
            },
            icon: Icon(Icons.grid_view)),
        IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.lock_outline)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
