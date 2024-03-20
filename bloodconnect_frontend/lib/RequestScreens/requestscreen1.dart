import 'package:flutter/material.dart';

class RequestScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Blood Donors Screen'),
            Text(
                "This section displays all users who have registered with the same blood group as the current user. Additionally, a filter option is provided below to allow users to view individuals from all blood groups."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showFilterDialog(context);
              },
              child: Text('Filter'),
            ),
            // Add your content here for Blood Donors screen
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    String bloodGroup = '';
    String location = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Blood Group'),
                onChanged: (value) {
                  bloodGroup = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  location = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform filtering based on bloodGroup and location
                // You can pass these values to another function or handle filtering logic here
                Navigator.of(context).pop();
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
