import 'package:drowse_detector/Screens/Authentication.dart';
import 'package:drowse_detector/Screens/Starting_Screen.dart';
import 'package:drowse_detector/Screens/Welcome_Screen.dart';
import 'package:flutter/material.dart';

class EndingScreen extends StatefulWidget {
  const EndingScreen({super.key});

  @override
  State<EndingScreen> createState() => _EndingScreenState();
}

class _EndingScreenState extends State<EndingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                height: 220,
                width: 220,
                child: Image(image: AssetImage('assets/stop.png')),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  AuthenticationHelper().signOut().then((value) =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StartingScreen())));
                },
                child: Text(
                  'Take a break',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    primary: Color.fromARGB(255, 18, 79, 129),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99))),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
                child: Text(
                  'Continue',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    primary: Color.fromARGB(255, 18, 79, 129),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: 200,
                child: Image(image: AssetImage('assets/drowsy.png')),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
