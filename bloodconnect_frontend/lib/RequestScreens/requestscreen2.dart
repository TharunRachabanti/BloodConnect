import 'package:flutter/material.dart';
import 'package:bloodconnect_frontend/TestScreens/requesttweetscreen.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:bloodconnect_frontend/services/currentuser.dart';

class RequestScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Submit your request to seek blood donation.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
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
          _buildStyledTextField(
            controller: nameController,
            labelText: 'Name',
          ),
          SizedBox(height: 10),
          _buildStyledTextField(
            controller: bloodgroupController,
            labelText: 'Blood Group',
          ),
          SizedBox(height: 10),
          _buildStyledTextField(
            controller: genderController,
            labelText: 'Gender',
          ),
          SizedBox(height: 10),
          _buildStyledTextField(
            controller: addressController,
            labelText: 'Address',
          ),
          SizedBox(height: 10),
          _buildStyledTextField(
            controller: phonenumberController,
            labelText: 'Phone Number',
          ),
          SizedBox(height: 10),
          _buildStyledTextField(
            controller: tagController,
            labelText: 'Tag',
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
              Text('Show in Home'),
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
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}
