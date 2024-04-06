import 'package:bloodconnect_frontend/LoginScreens/welcomescreen.dart';
import 'package:bloodconnect_frontend/firebase_options.dart';
import 'package:bloodconnect_frontend/homescreen.dart';
import 'package:bloodconnect_frontend/tabscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
