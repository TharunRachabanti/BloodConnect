import 'package:bloodconnect_frontend/tabscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Blood Group'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Sex'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabScreen()),
                );
                // Navigate to TabScreen using Navigator
                // Handle registration logic here
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
