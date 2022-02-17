

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
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
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: List.generate(200, (index)  {
              return Container(
                padding:  EdgeInsets.all(8),
                color: Colors.grey,
                child: Stack(
                  children: <Widget>[
                    Positioned(child: myPopMenu(),right: 0,),Positioned(child: likePopupMenu(), bottom: 0, right: 0,)
                  ],
                ),
              );
            }),
          )),
    );
  }
}

Widget myPopMenu() {
  return PopupMenuButton(
    color: Color(0xFF29292B),
      enabled: true,
      onSelected: (value) {
      },
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 1,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),

                ),
                Text('Share',style: TextStyle(color: Colors.white),)
              ],
            )),
        PopupMenuItem(
            value: 2,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),

                ),
                Text('Rename',style: TextStyle(color: Colors.white))
              ],
            )),
        PopupMenuItem(
            value: 3,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                ),
                Text('Remove',style: TextStyle(color: Colors.white))
              ],
            )),
      ]);
}

Widget likePopupMenu(){
  return  IconButton(onPressed: () { },
      icon: Icon(Icons.favorite_border_outlined),color: Color(0xFF6200EE) ,
  );
}