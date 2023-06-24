import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_chat/apis/apis.dart';
import 'package:lets_chat/main.dart';
import 'package:lets_chat/screens/auth/login_screen.dart';
import 'package:lets_chat/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // init state to remove this screen and show the homescreen
  void initState() {
    super.initState();
    // after 2 second the splash screen will be removed
    Future.delayed(Duration(milliseconds: 2000), () {
      // to bring back our app from full screen to button enabled and status bar functionality
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // change color of the status bar
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      // removing this screen after 2 seconds

      if (Apis.auth.currentUser != null) {
        // if user is akready loged in previously
        log(" \ncurrent_user : ${Apis.auth.currentUser}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        // else take it from splash screen to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // logo of the app
          Positioned(
              top: mq.height * .25,
              right: mq.height * .14,
              width: mq.width * 0.5,
              child: Image.asset("images/chat.png")),
// text for showing the moto of the app
          Positioned(
              bottom: mq.height * .15,
              width: mq.width,
              child: Text(
                "Made in India ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              )),
        ],
      ),
    );
  }
}
