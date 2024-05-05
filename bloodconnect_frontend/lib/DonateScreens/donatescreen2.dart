import 'package:bloodconnect_frontend/TestScreens/requestcardscreen.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class DonateScreen2 extends StatefulWidget {
  @override
  _DonateScreen2State createState() => _DonateScreen2State();
}

class _DonateScreen2State extends State<DonateScreen2> {
  String? _selectedBloodGroup;
  String? _selectedLocation;
  List<RequesterData> _allData = [];
  List<RequesterData> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _allData = await Api.getrequestersdata();
    setState(() {
      _filteredData = _allData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          onTap: _showFilterDialog,
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredData.length,
        itemBuilder: (BuildContext context, int index) {
          RequesterData requesterData = _filteredData[index];
          return Card(
            child: ExpansionTile(
              title: Text(requesterData.name ?? ''),
              subtitle: Text(requesterData.bloodgroup ?? ''),
              children: [
                _buildExpandedContent(requesterData),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpandedContent(RequesterData requesterData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Blood Group: ${requesterData.bloodgroup ?? ''}'),
        Text('Gender: ${requesterData.gender ?? ''}'),
        Text('Address: ${requesterData.address ?? ''}'),
        Text('Phone Number: ${requesterData.phonenumber ?? ''}'),
        Text('Tag: ${requesterData.tag ?? ''}'),
        Text('Show in Profile: ${requesterData.showInProfile ?? ''}'),
      ],
    );
  }

  void _showFilterDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Blood Group'),
                onChanged: (value) {
                  setState(() {
                    _selectedBloodGroup = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                _applyFilters();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _applyFilters() {
    setState(() {
      _filteredData = _allData
          .where((data) =>
              (data.bloodgroup == _selectedBloodGroup ||
                  _selectedBloodGroup == null) &&
              (data.address?.contains(_selectedLocation ?? '') ?? false))
          .toList();
    });
  }
}
