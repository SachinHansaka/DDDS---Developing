import 'package:drowse_detector/Screens/Check_Auth.dart';
import 'package:drowse_detector/Screens/Example_Screen.dart';
import 'package:drowse_detector/Screens/Login_Screen.dart';
import 'package:drowse_detector/Screens/Splash_Screen.dart';
import 'package:flutter/material.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(image: AssetImage('assets/drowsy.png')),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => CheckAuth()));
              },
              child: Text(
                'Get Started',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  primary: Color.fromARGB(255, 18, 79, 129),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99))),
            ),
          ],
        ),
      ),
    );
  }
}
