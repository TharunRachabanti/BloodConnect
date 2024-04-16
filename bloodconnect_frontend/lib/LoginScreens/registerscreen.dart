import 'package:bloodconnect_frontend/tabscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final User user;

  const RegisterScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _ageController = TextEditingController();
    final TextEditingController _bloodGroupController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _sexController = TextEditingController();

    Future<void> _registerUser() async {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _nameController.text.trim(), // Ensure 'name' field is set
          'age': _ageController.text.trim() ?? '',
          'bloodGroup': _bloodGroupController.text.trim() ?? '',
          'address': _addressController.text.trim() ?? '',
          'sex': _sexController.text.trim() ?? '',
          'timestamp': FieldValue.serverTimestamp(), // Add timestamp field
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TabScreen(),
          ),
        );
      } catch (e) {
        // Handle errors here
        print('Error registering user: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: _bloodGroupController,
              decoration: InputDecoration(labelText: 'Blood Group'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _sexController,
              decoration: InputDecoration(labelText: 'Sex'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
