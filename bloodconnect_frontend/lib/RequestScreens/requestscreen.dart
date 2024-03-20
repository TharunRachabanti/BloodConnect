import 'package:bloodconnect_frontend/RequestScreens/requestscreen1.dart';
import 'package:bloodconnect_frontend/RequestScreens/requestscreen2.dart';
import 'package:bloodconnect_frontend/RequestScreens/requestscreen3.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Blood Donors'),
              Tab(text: 'Request/Poster Form'),
              Tab(text: 'Tweet'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab - Blood Donors
            RequestScreen1(),
            // Second tab - Request/Poster Form
            RequestScreen2(),
            // Third tab - Tweet
            RequestScreen3(),
          ],
        ),
      ),
    );
  }
}
