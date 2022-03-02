import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/enums.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:gallery_app/screen/widget/image_picker.dart';
import 'package:gallery_app/screen/widget/list_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _pickedImage;
  //Method to pick the image via camera
  Future<void> _takePicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageFile = await saveImagePermantely(image.path);
    setState(() {
      this._pickedImage = imageFile;
    });
  }

  Future<File> saveImagePermantely(String imgpath) async {
    final dir = await syspath.getApplicationDocumentsDirectory();
    final name = path.basename(imgpath);
    final image = File('${dir.path}/$name');
    return File(imgpath).copy(image.path);
  }

  Future uploadImageToFirebase(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: ApplicationToolbar(),
      extendBody: true,
      body: ListScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6200EE),
        //Floating action button on Scaffold
        onPressed: () {
          _takePicture();
        },
        child: Icon(Icons.add_a_photo_outlined), //icon inside button
      ),

      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Color(0xFF29292B),
        shape: CircularNotchedRectangle(),
        elevation: 0,
        //shape of notch

        //notche margin between floating button and bottom appbar
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
          elevation: 0,
          showSelectedLabels: true,
          selectedItemColor: Color(0xFF6200EE),
          unselectedItemColor: Colors.white,
          selectedFontSize: 16.0,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
                label: 'SHARED', icon: Icon(Icons.supervisor_account_outlined))
          ],
        ),
      ),
    );
  }
}

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  final GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("GalleryApp"),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: <Widget>[
        IconButton(
            onPressed: () {
              paginatorGlobalKey.currentState?.changeState(
                  listType: ListType.GRID_VIEW,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2));
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
