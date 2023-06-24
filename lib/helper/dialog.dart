import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Color.fromARGB(255, 2, 51, 91),
      behavior: SnackBarBehavior.floating,
    ));
  }


}
