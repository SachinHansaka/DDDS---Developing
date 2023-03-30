import 'package:drowse_detector/Screens/Login_Screen.dart';
import 'package:drowse_detector/Screens/Welcome_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool _isloading = false;
  bool Auth = false;
  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  void checkLoggedIn() {
    setState(() {
      _isloading = true;
    });
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Auth = true;
    } else {
      Auth = false;
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (Auth == true) {
      child = WelcomeScreen();
    } else {
      child = LoginScreen();
    }
    return Scaffold(
      body: _isloading ? Center(child: CupertinoActivityIndicator()) : child,
    );
  }
}
