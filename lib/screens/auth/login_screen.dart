import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/helper/dialog.dart';
import 'package:lets_chat/main.dart';
import 'package:lets_chat/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../apis/apis.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // saying animation is false in satarting
  bool _isAnimate = false;
  @override
  // to make animation true we use init state
  void initState() {
    super.initState();
    // after 0.5 second animation will be true
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleClickButton() {
    showDialog(context: context, builder: (_)=> Center(child: CircularProgressIndicator()));
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if (user != null) {
        log("\nuser : ${user.user}");
        log("\nuserInfo : ${user.additionalUserInfo}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
      return;
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
     await InternetAddress.lookup("google.com");
      // Trigger the authentication flow

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await Apis.auth.signInWithCredential(credential);
    } catch (e) {
      log("\nsiginGoogle : $e ");
    Dialogs.showSnackBar(context, "check your internet connection");
    return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome to Lets Chat App"),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            width: mq.width * .5,
            top: mq.height * 0.15,
            // now the animation is true and it will go to he right after that it will becaome false
            right: _isAnimate ? mq.width * .25 : -mq.width * 0.25,
            duration: Duration(seconds: 1),
            child: Image.asset("images/chat.png"),
          ),
          Positioned(
            height: mq.height * .06,
            bottom: mq.height * 0.15,
            left: mq.width * .1,
            width: mq.width * .8,
            child: ElevatedButton.icon(
              onPressed: () {
                _handleGoogleClickButton();
              },
              icon: Image.asset(
                "images/search.png",
                height: mq.height * .04,
              ),
              label: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      children: [
                    TextSpan(text: "  Sign In with "),
                    TextSpan(
                      text: "Google",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ])),
            ),
          )
        ],
      ),
    );
  }
}
