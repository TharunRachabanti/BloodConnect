import 'package:flutter/material.dart';

class DonateScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Blood Group Seekers'),
      ),
      body: Text(
        'In this interface, users with matching blood types to the current user\'s will be shown, along with their respective request information, from submissions made on the request screen.',
        style: TextStyle(fontSize: 12), // Adjust font size as needed
      ),
    );
  }
}
