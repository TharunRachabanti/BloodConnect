import 'dart:io';

import 'package:bloodconnect_frontend/services/api.dart';
import 'package:bloodconnect_frontend/services/currentuser.dart';
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
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
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        await _uploadImageAndMessage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 50.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Select Image',
        backgroundColor: Colors.red,
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
        final String message = _messageController.text;

        if (_image != null) {
          final Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('images/${DateTime.now().millisecondsSinceEpoch}');

          final UploadTask uploadTask = storageRef.putFile(_image!);

          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            double progress = snapshot.bytesTransferred / snapshot.totalBytes;
            print('Upload progress: $progress');
          });

          final TaskSnapshot taskSnapshot = await uploadTask;
          imageUrl = await taskSnapshot.ref.getDownloadURL();
        }

        // Get the current username
        String currentUsername = await getCurrentUserNameFromFirestore();

        // Send image URL, message, and username to the API
        await Api.uploadImageData(imageUrl, message, currentUsername);

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error uploading image. Please try again later.',
            style: TextStyle(fontSize: 16.0),
          ),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: _uploadImageAndMessage,
          ),
        ));
      }
    }
  }
}
