import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gallery_app/screen/authentication/services/authForm.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    UserCredential result;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        result = await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(
                () => showSnackBar("Login Successful", Duration(seconds: 3)));
      } else {
        result = await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .whenComplete(() =>
                showSnackBar("Registration successful", Duration(seconds: 3)));
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user?.uid)
          .set({'userName': username, 'email': email});
    } on PlatformException catch (e) {
      print(e.message.toString().trim());
      var message = 'An error occurred';

      if (e.message != null) {
        message = e.message.toString().trim();
        showSnackBar(message, Duration(seconds: 5));

      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      var msg = e.toString();
      showSnackBar(msg, Duration(seconds: 5));
      print(e);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text("Gallery App"),
        backgroundColor: Color(0xFF29292B),
      ),
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }

  void showSnackBar(String snackBarText, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(snackBarText),
      duration: duration,
      backgroundColor: Theme.of(context).primaryColor,
    ));
  }
}
