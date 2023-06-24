import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_chat/screens/spalsh_screen.dart';

import 'firebase_options.dart';



// intialize the size variable here 
late Size mq;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // to show the splash screen on the full screen 
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // loading all tha component after the portrait mode is setup
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
// using the firebase method
     _intializeFirebase(); 
  runApp(const MyApp());
  } 
 );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lets Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // appbar theme to use globally 
       appBarTheme: AppBarTheme(
        color: Theme.of(context).colorScheme.onSecondary,
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        )
       ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// method to intialize the firebase in seprate method then use it on the main method
_intializeFirebase()async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}