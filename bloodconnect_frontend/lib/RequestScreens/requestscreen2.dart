import 'package:bloodconnect_frontend/profilescreen.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class RequestScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request/Poster Form Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'In this screen, if the user submits the form without selecting the checkbox, the requested details will appear in the "Blood Seekers" section of the "Donate" screen. However, if the user selects the checkbox, an additional pre-made poster will be generated using the provided details. This poster will then be posted on the homepage for wider visibility.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              RequestForm(),
            ],
          ),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController tagController = TextEditingController();

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
              Text('Show in Profile'),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                var data = {
                  "rname": nameController.text,
                  "rbloodgroup": bloodgroupController.text,
                  "rgender": genderController.text,
                  "raddress": addressController.text,
                  "rphonenumber": phonenumberController.text,
                  "rtag": tagController.text,
                };

                // Pass _isChecked as a boolean to the API call
                Api.addrequesterdata(data, _isChecked);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
