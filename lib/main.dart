import 'dart:js';

import 'package:eos_clock/screens/login_screen.dart';
import 'package:eos_clock/screens/my_home_page.dart';
import 'package:eos_clock/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/color_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorService.createMaterialColor(Color(0xFF1CAF49))),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //인증반은 토큰을 가졌다면
            return MyHomePage();
          }
          return LoginScreen();
        },
      )
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "EOS Clock",
        theme: ThemeData(primarySwatch: Colors.lightGreen, fontFamily: 'Teko'),
        home: MyHomePage()
    );
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: ColorService.createMaterialColor(Color(0xFF1CAF49))),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/home': (context) => MyHomePage(),
          '/signup': (context) => SignupScreen(),
        },
      ),
    );
  }
}