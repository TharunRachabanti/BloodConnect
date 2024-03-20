import 'package:flutter/material.dart';

class RequestScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tweet Screen'),
            Text(
                'In this screen, users can express the urgency of a patients need for blood by typing their message. They can also attach related images of the patient. Once they harve conveyed the urgency effectively, they simply click Submit. This tweet will then be prominently displayed on the home screen, ensuring maximum visibility and potential assistance for the patient.'),
            // Tweet Input
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your tweet...',
                  border: OutlineInputBorder(),
                ),
                maxLines: null, // Allows multiline input
              ),
            ),
            // Image Input from Device Storage
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement image selection from device storage
                },
                child: Text('Select Image'),
              ),
            ),
            // Submit Option
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement tweet submission logic
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
