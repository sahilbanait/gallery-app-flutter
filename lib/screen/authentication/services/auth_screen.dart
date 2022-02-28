import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/screen/authentication/services/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
        result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
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
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
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
}
