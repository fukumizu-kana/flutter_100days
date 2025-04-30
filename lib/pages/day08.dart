import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Day08 extends StatelessWidget {
  const Day08({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F7),
      appBar: AppBar(
        title: const Text(
          'flutter_spinkit',
          style: TextStyle(
            fontFamily: 'ZenMaruGothic',
            fontWeight: FontWeight.bold,
            color: Color(0xFFCE7DA5),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFCE7DA5)),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitChasingDots(
              color: Color(0xFFCE7DA5),
              size: 60.0,
            ),
            SpinKitFadingCube(
              color: Color(0xFFCE7DA5),
              size: 50.0,
            ),
            SpinKitPumpingHeart(
              color: Color(0xFFCE7DA5),
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
