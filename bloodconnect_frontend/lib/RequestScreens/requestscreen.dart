import 'package:bloodconnect_frontend/RequestScreens/requestscreen1.dart';
import 'package:bloodconnect_frontend/RequestScreens/requestscreen2.dart';
import 'package:bloodconnect_frontend/RequestScreens/requestscreen3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text(
              'Request',
              style: GoogleFonts.dmSerifDisplay(
                letterSpacing: 2,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Colors.green, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 5),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.black,
                    indicatorPadding: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 5), // Adjust padding here
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    tabs: const [
                      _StyledTab('Blood Donors'),
                      _StyledTab('Request/Poster'),
                      _StyledTab('Tweet'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StyledTab extends StatelessWidget {
  final String text;

  const _StyledTab(this.text);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
