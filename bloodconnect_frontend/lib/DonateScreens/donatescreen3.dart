import 'dart:io';

import 'package:bloodconnect_frontend/services/api.dart';
import 'package:bloodconnect_frontend/services/currentuser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DonateScreen3 extends StatefulWidget {
  @override
  _DonateScreen3State createState() => _DonateScreen3State();
}

class _DonateScreen3State extends State<DonateScreen3> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _messageController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  String imageUrl = '';
  late String _currentUserName; // Added

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserName(); // Fetch current user's name when the screen initializes
  }

  void _fetchCurrentUserName() async {
    // Fetch current user's name from Firebase Firestore
    _currentUserName = await getCurrentUserNameFromFirestore();
    setState(() {}); // Update the state to reflect the fetched user name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Donate Tweet'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter your message here',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _getImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(
                    child:
                        CircularProgressIndicator()) // Show loading indicator if uploading
                : ElevatedButton(
                    onPressed: () async {
                      // Call _uploadImageAndMessage function
                      await _uploadDonateImageAndMessage();
                    },
                    child: Text('Submit'),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Select Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadDonateImageAndMessage() async {
    if (_currentUserName == null || _currentUserName.isEmpty) {
      // Handle case where current user's name is not available
      print('Current user name is not available');
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Get message text
        final String message = _messageController.text;

        // Upload image to Firebase Storage
        if (_image != null) {
          final Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('Donateimages/${DateTime.now().millisecondsSinceEpoch}');

          final UploadTask uploadTask = storageRef.putFile(_image!);

          // Show upload progress using a progress indicator
          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            double progress = snapshot.bytesTransferred / snapshot.totalBytes;
            print('Upload progress: $progress');
          });

          // Wait for the upload to complete
          final TaskSnapshot taskSnapshot = await uploadTask;
          imageUrl = await taskSnapshot.ref.getDownloadURL();

          // Now you can use imageUrl and message for further processing
          print('Image URL: $imageUrl');
          print('Message: $message');

          // Call API to upload image data
          Api.uploadDonateImageData(
              imageUrl, message, _currentUserName); // Pass the current username

          // Optionally, you can navigate to another screen or show a success message here
        }

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          _isLoading = false;
        });

        // Handle error gracefully, show a snackbar or alert dialog
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error uploading image. Please try again later.'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: _uploadDonateImageAndMessage, // Retry the upload
          ),
        ));
      }
    }
  }
}
