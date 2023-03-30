import 'dart:async';
import 'package:drowse_detector/Screens/Starting_Screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => StartingScreen())));
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Text(
          'Welcome!',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
