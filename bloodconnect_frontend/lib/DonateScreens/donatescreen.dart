import 'package:bloodconnect_frontend/DonateScreens/donatescreen1.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen2.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen3.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Donate'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Your Blood Group Seekers'),
              Tab(text: 'Other Blood Group Seekers'),
              Tab(text: 'Posters/Tweets'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Your content for the first tab
            _buildTabContent(context, DonateScreen1()),
            // Your content for the second tab
            _buildTabContent(context, DonateScreen2()),
            // Your content for the third tab
            _buildTabContent(context, DonateScreen3()),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, Widget screen) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => screen);
      },
    );
  }
}
