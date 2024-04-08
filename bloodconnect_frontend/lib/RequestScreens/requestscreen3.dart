import 'dart:io';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class RequestScreen3 extends StatefulWidget {
  @override
  _RequestScreen3State createState() => _RequestScreen3State();
}

class _RequestScreen3State extends State<RequestScreen3> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _messageController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Tweet'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 150,
                    )
                  : SizedBox(),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator() // Show loading indicator if uploading
                  : ElevatedButton(
                      onPressed: () async {
                        // Call _uploadImageAndMessage function
                        await _uploadImageAndMessage();

                        // If _uploadImageAndMessage was successful, call Api.uploadImageData
                        if (!_isLoading) {
                          Api.uploadImageData(
                              imageUrl, _messageController.text);
                        }
                      },
                      child: Text('Submit'),
                    ),
            ],
          ),
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

  Future<void> _uploadImageAndMessage() async {
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
              .child('images/${DateTime.now().millisecondsSinceEpoch}');

          final UploadTask uploadTask = storageRef.putFile(_image!);

          // Show upload progress using a progress indicator
          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            double progress = snapshot.bytesTransferred / snapshot.totalBytes;
            print('Upload progress: $progress');
          });

          // Wait for the upload to complete
          final TaskSnapshot taskSnapshot = await uploadTask;
          imageUrl = await taskSnapshot.ref.getDownloadURL();
        }

        // Now you can use imageUrl and message for further processing
        print('Image URL: $imageUrl');
        print('Message: $message');

        setState(() {
          _isLoading = false;
        });

        // Optionally, you can navigate to another screen or show a success message here
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
            onPressed: _uploadImageAndMessage, // Retry the upload
          ),
        ));
      }
    }
  }
}
