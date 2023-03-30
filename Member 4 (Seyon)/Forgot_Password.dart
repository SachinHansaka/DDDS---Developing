import 'package:drowse_detector/Screens/Authentication.dart';
import 'package:drowse_detector/Screens/Login_Screen.dart';
import 'package:drowse_detector/Screens/SignUp_Screen.dart';
import 'package:drowse_detector/Screens/Welcome_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image(image: AssetImage('assets/drowsy.png')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Material(
                  color: Colors.white,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: screenWidth,
                    height: 250,
                    decoration: BoxDecoration(),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 27),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: 'E-mail',
                                    hintStyle: TextStyle(color: Colors.black),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AuthenticationHelper()
                                    .forgotPassword(
                                  email: emailController.text.trim(),
                                )
                                    .then((result) {
                                  if (result == null) {
                                    showFlash(
                                      context: context,
                                      duration: const Duration(seconds: 2),
                                      builder: (_, c) {
                                        return Flash(
                                          controller: c,
                                          barrierDismissible: false,
                                          alignment: Alignment.bottomCenter,
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          backgroundColor:
                                              Color.fromARGB(255, 18, 79, 129),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 12),
                                            child: Text(
                                              "Successfully sent",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  } else {
                                    showFlash(
                                      context: context,
                                      duration: const Duration(seconds: 2),
                                      builder: (_, c) {
                                        return Flash(
                                          controller: c,
                                          barrierDismissible: false,
                                          alignment: Alignment.bottomCenter,
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          backgroundColor:
                                              Color.fromARGB(255, 18, 79, 129),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 12),
                                            child: Text(
                                              "submit failed",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             WelcomeScreen()));
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 25),
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  primary: Color.fromARGB(255, 18, 79, 129),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(99))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future _logIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim());
  //   } on FirebaseAuthException catch (e) {}
  // }
}
