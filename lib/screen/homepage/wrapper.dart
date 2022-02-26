import 'package:Gallery_App/screen/authentication/Login.dart';
import 'package:Gallery_App/screen/homepage/HomePage.dart';
import 'package:Gallery_App/screen/services/auth_form.dart';
import 'package:Gallery_App/screen/services/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:Gallery_App/main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Return home on successfully authentication
    return AuthScreen();
  }
}
