import 'package:flutter/material.dart';

class DonateScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Blood Group Seekers'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'In this interface, upon selecting filter options for blood group type and location, the system displays users matching the specified criteria. These details originate from the request screen, showcasing individuals with the desired blood group who are present in the chosen location.',
          ),
          SizedBox(height: 20), // Add some space between text and filter
          Text(
            'Filter Options:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10), // Add some space between filter options
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Blood Group Type',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10), // Add some space between text fields
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              height: 20), // Add some space between filter and submit button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Implement search logic here
              },
              child: Text('Submit to Search'),
            ),
          ),
        ],
      ),
    );
  }
}
