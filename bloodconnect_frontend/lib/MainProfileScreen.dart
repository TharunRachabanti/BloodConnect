import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({Key? key}) : super(key: key);

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  late String _userName;
  late String _userAge;
  late String _userBloodGroup;
  late String _userAddress;
  late String _userSex;

  @override
  void initState() {
    super.initState();
    _userName = '';
    _userAge = '';
    _userBloodGroup = '';
    _userAddress = '';
    _userSex = '';
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _userName = userDoc.get('name') ?? '';
          _userAge = userDoc.get('age') ?? '';
          _userBloodGroup = userDoc.get('bloodGroup') ?? '';
          _userAddress = userDoc.get('address') ?? '';
          _userSex = userDoc.get('sex') ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Name: $_userName'),
            Text('Age: $_userAge'),
            Text('Blood Group: $_userBloodGroup'),
            Text('Address: $_userAddress'),
            Text('Sex: $_userSex'),
          ],
        ),
      ),
    );
  }
}
