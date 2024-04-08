import 'package:bloodconnect_frontend/LoginScreens/registerscreen.dart';
import 'package:bloodconnect_frontend/tabscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrailLoginscreen extends StatefulWidget {
  const TrailLoginscreen({Key? key}) : super(key: key);

  @override
  _TrailLoginscreenState createState() => _TrailLoginscreenState();
}

class _TrailLoginscreenState extends State<TrailLoginscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final User? user = userCredential.user;
      if (user != null) {
        // Check if user is new or existing
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // User is existing, navigate to TabScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabScreen(),
            ),
          );
        } else {
          // User is new, navigate to RegisterScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterScreen(user: user),
            ),
          );
        }
      }
    } catch (e) {
      // Handle errors here
      print('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
