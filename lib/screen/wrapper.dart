import 'package:Gallery/screen/homepage/HomePage.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Return home on successfully authentication
    return HomePage();
  }
}
