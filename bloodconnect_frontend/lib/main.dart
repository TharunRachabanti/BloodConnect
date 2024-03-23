import 'package:bloodconnect_frontend/LoginScreens/welcomescreen.dart';
import 'package:bloodconnect_frontend/homescreen.dart';
import 'package:bloodconnect_frontend/tabscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabScreen(),
    );
  }
}
