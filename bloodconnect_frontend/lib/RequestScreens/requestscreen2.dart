import 'package:bloodconnect_frontend/profilescreen.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class RequestScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Request/Poster Form Screen'),
            Text(
                'In this screen, if the user submits the form without selecting the checkbox, the requested details will appear in the "Blood Seekers" section of the "Donate" screen. However, if the user selects the checkbox, an additional pre-made poster will be generated using the provided details. This poster will then be posted on the homepage for wider visibility.'),
            SizedBox(height: 20),
            RequestForm(),
          ],
        ),
      ),
    );
  }
}

class RequestForm extends StatefulWidget {
  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  var nameController = TextEditingController();
  var bloodgroupController = TextEditingController();
  var genderController = TextEditingController();
  var addressController = TextEditingController();
  var phonenumberController = TextEditingController();
  var tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: bloodgroupController,
            decoration: InputDecoration(labelText: 'Blood Group'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your blood group';
              }
              return null;
            },
          ),
          TextFormField(
            controller: genderController,
            decoration: InputDecoration(labelText: 'Gender'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your gender';
              }
              return null;
            },
          ),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: phonenumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: tagController,
            decoration: InputDecoration(labelText: 'Tag'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a tag';
              }
              return null;
            },
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
              ),
              Text('Post Poster '),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                if (_isChecked) {
                  // Handle request submission and poster posting
                  var data = {
                    "rname": nameController.text,
                    "rbloodgroup": bloodgroupController.text,
                    "rgender": genderController.text,
                    "raddress": addressController.text,
                    "rphonenumber": phonenumberController.text,
                    "rtag": tagController.text,
                  };

                  // Call API for request submission
                  Api.addrequesterdata(data);

                  // Post the pre-made poster
                  await Api.posterrequestdetails().then((requestData) {
                    // Navigate to profile screen with fetched data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(data: requestData),
                      ),
                    );
                  }).catchError((error) {
                    // Handle error if any
                    print("Error fetching data: $error");
                  });
                } else {
                  // Handle request submission only
                  var data = {
                    "rname": nameController.text,
                    "rbloodgroup": bloodgroupController.text,
                    "rgender": genderController.text,
                    "raddress": addressController.text,
                    "rphonenumber": phonenumberController.text,
                    "rtag": tagController.text,
                  };
                  // Call API for request submission
                  Api.addrequesterdata(data);
                }
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
