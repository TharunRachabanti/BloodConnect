import 'package:bloodconnect_frontend/MainProfileScreen.dart';
import 'package:bloodconnect_frontend/RequestScreens/requestscreen.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen.dart';
import 'package:bloodconnect_frontend/homescreen.dart';
import 'package:bloodconnect_frontend/mainhome.dart';
import 'package:bloodconnect_frontend/profilescreen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(),
      DonateScreen(),
      RequestScreen(),
      ProfileScreen(),
      MainProfileScreen(),
      MainHomeScreen(), // No parameters passed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.request_page,
              color: Colors.black,
            ),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.ac_unit_sharp,
              color: Colors.black,
            ),
            label: 'MProfile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
