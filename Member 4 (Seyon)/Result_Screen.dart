
import 'dart:io';

import 'package:drowse_detector/Screens/Ending_Screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ResultScreen extends StatefulWidget {
  final XFile image;

  const ResultScreen({super.key, required this.image});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(color: Colors.grey),
              child: Image.file(File(widget.image.path)),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => EndingScreen()));
              },
              child: Text(
                'Stop',
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
      )),
    );
  }
}
