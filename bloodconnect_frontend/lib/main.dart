import 'package:bloodconnect_frontend/LoginScreens/traillogin.dart';
import 'package:bloodconnect_frontend/firebase_options.dart';
import 'package:bloodconnect_frontend/tabscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize App Check with Play Integrity provider for Android
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('YOUR_RECAPTCHA_SITE_KEY'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrailLoginscreen(),
    );
  }
}
