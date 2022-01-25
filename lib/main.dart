

import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: ApplicationToolbar(),
        extendBody: true,
        body: CenterContainer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF6200EE),
          //Floating action button on Scaffold
          onPressed: () {
            //code to execute on button press
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
            selectedItemColor:Color(0xFF6200EE),
            unselectedItemColor: Colors.white,
            selectedFontSize: 16.0,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle:TextStyle(fontWeight: FontWeight.bold),

            items: [
              BottomNavigationBarItem(
                  title: Text('HOME'),
                  icon: Icon(Icons.home_outlined),
              ),

              BottomNavigationBarItem(
                  title: Text('SHARED'), icon: Icon(Icons.supervisor_account_outlined))
            ],
          ),
        ),
      ),
    );
  }
}

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: Text("GalleryApp"),
      backgroundColor: Color(0xFF29292B),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.grid_view)),
        IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
        IconButton(onPressed: () {}, icon: Icon(Icons.lock_outline)),
      ],
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}

class CenterContainer extends StatefulWidget {
  const CenterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    )));
  }

  @override
  _MyGridScreenState createState() => _MyGridScreenState();

  }

class _MyGridScreenState extends State<CenterContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: Container(

                )
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Second', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Third', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Four', style: TextStyle(fontSize: 20)),
                color: Colors.yellow,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Fifth', style: TextStyle(fontSize: 20)),
                color: Colors.yellow,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Six', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
              ),
            ],
          )),
    );
  }
}

