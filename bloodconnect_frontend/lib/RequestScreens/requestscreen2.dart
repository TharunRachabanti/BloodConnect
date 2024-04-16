import 'package:flutter/material.dart';
import 'package:bloodconnect_frontend/TestScreens/requesttweetscreen.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:bloodconnect_frontend/services/currentuser.dart';

class RequestScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Submit your request to seek blood donation.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  late String _currentUserName = '';

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserName();
  }

  void _fetchCurrentUserName() async {
    _currentUserName = await getCurrentUserNameFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: bloodgroupController,
            decoration: InputDecoration(
              labelText: 'Blood Group',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your blood group';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: genderController,
            decoration: InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your gender';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: phonenumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: tagController,
            decoration: InputDecoration(
              labelText: 'Tag',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a tag';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 20),
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

                // Pass _isChecked as a boolean and _currentUserName as a string to the API call
                Api.addrequesterdata(data, _isChecked, _currentUserName);
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
