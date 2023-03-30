import 'package:drowse_detector/Screens/Authentication.dart';
import 'package:drowse_detector/Screens/Forgot_Password.dart';
import 'package:drowse_detector/Screens/SignUp_Screen.dart';
import 'package:drowse_detector/Screens/Welcome_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    height: 375,
                    decoration: BoxDecoration(),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: _isloading
                            ? Center(child: CupertinoActivityIndicator())
                            : Column(
                                children: [
                                  Text(
                                    'Log In',
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
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPassword()));
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _logIn();
                                    },
                                    child: Text(
                                      'Log In',
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
                                        "Don't have an account?     ",
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
                                                          SignUpScreen()));
                                        },
                                        child: Text(
                                          'Sign Up',
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

  Future _logIn() async {
    setState(() {
      _isloading = true;
    });
    AuthenticationHelper()
        .signIn(
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
                  "Successfully loggedin",
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
                  "Log In failed",
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
