import 'package:drowse_detector/Screens/Example_Screen.dart';
import 'package:drowse_detector/Screens/Login_Screen.dart';
import 'package:drowse_detector/Screens/Splash_Screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image(image: AssetImage('assets/drowsy.png')),
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Color.fromARGB(255, 18, 79, 129),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 200,
                width: 200,
                child: Image(image: AssetImage('assets/scan.png')),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => ExampleScreen()));
                },
                child: Text(
                  'Detect Drowsiness',
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
      ),
    );
  }
}
