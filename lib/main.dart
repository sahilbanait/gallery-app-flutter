import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_app/screen/homepage/homepage.dart';
import 'package:gallery_app/screen/homepage/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_app/screen/authentication/services/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,  snapshot ) {
          if(snapshot.hasData){
            return HomePage();
          }
          return AuthScreen();
        }),
      theme: ThemeData(
          fontFamily: 'RobotoMono',
          primarySwatch: Colors.deepPurple,
          backgroundColor: Colors.deepPurple[200],

          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.deepPurple,
            textTheme: ButtonTextTheme.primary,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )),
      title: "Gallery App",
    );
  }
}
