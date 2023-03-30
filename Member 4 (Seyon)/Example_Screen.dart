import 'dart:io';
import 'package:camera/camera.dart';
import 'package:drowse_detector/Screens/Result_Screen.dart';
import 'package:drowse_detector/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ExampleScreen extends StatefulWidget {
  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _photo;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Place your camera as shown in the picture',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: 300,
                child: Image(
                  image: AssetImage('assets/person.png'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: 125,
                child: Camera(),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  imgFromGallery();
                },
                child: Text(
                  'Start',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
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

  Future imgFromGallery() async {
    var pickImage;
    XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      if (pickedFile != null) {
        pickImage = pickedFile;
        _photo = File(pickedFile.path);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ResultScreen(
                  image: pickImage,
                )));
      }
    });
  }
}

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}
