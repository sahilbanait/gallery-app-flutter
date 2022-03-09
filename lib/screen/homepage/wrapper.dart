
import 'package:gallery_app/screen/authentication/services/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Return home on successfully authentication
    return AuthScreen();
  }
}
