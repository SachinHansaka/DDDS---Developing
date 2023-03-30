import 'package:drowse_detector/Screens/Authentication.dart';
import 'package:drowse_detector/Screens/Login_Screen.dart';
import 'package:drowse_detector/Screens/Welcome_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;
  bool _isloading = false;

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
                    height: 350,
                    decoration: BoxDecoration(),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: _isloading
                            ? Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : Column(
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 27),
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
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: showPassword,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        suffix: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: IconButton(
                                            onPressed: () => setState(() =>
                                                showPassword = !showPassword),
                                            icon: Icon(
                                              showPassword
                                                  ? CupertinoIcons
                                                      .eye_slash_fill
                                                  : CupertinoIcons.eye_fill,
                                            ),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      signUp();
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 10),
                                        primary:
                                            Color.fromARGB(255, 18, 79, 129),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(99))),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account?     ",
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          LoginScreen()));
                                        },
                                        child: Text(
                                          'Log In',
                                          style: TextStyle(
                                              fontSize: 13,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  )
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

  Future signUp() async {
    setState(() {
      _isloading = true;
    });
    AuthenticationHelper()
        .signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
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
              borderRadius: BorderRadius.circular(99),
              backgroundColor: Color.fromARGB(255, 18, 79, 129),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "Successfully signedup",
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
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      } else {
        showFlash(
          context: context,
          duration: const Duration(seconds: 2),
          builder: (_, c) {
            return Flash(
              controller: c,
              barrierDismissible: false,
              alignment: Alignment.bottomCenter,
              borderRadius: BorderRadius.circular(99),
              backgroundColor: Color.fromARGB(255, 18, 79, 129),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "Sign up failed",
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
    setState(() {
      _isloading = false;
    });
  }
}
