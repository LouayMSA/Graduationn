import 'package:flutter/material.dart';
import 'package:irepair/pages/home.dart';
import 'package:irepair/pages/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
