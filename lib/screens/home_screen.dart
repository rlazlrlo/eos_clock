import 'package:firebase_auth/firebase_auth.dart';
import 'package:eos_clock/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../widget/clock_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        title: Text('Chat screen'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
            },
            icon: Icon(Icons.exit_to_app_rounded, color: Colors.white),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(flex: 2,),
            Image.asset('assets/images/eos_logo.png', height: 280,),
            Spacer(),
            ClockWidget(),
            Spacer(flex: 7,),
          ],
        ),
      ),
    );
  }
}