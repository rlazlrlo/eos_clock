import 'package:eos_clock/widget/clock_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        title: Text('EOS 시계 앱'),
        centerTitle: false,
        leading: Icon(Icons.access_time_filled),
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
      )
    );
  }
}
