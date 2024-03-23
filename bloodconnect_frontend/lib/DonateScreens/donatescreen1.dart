import 'package:bloodconnect_frontend/homescreen.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class _OtherBloodGroupsScreenState extends State<OtherBloodGroupsScreen> {
  String? _selectedBloodGroup;
  String? _selectedLocation;
  List<RequesterData> _filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterDialog,
        tooltip: 'Filter',
        child: Icon(Icons.filter_list),
      ),
      body: ListView.builder(
        itemCount: _filteredData.length,
        itemBuilder: (BuildContext context, int index) {
          RequesterData requesterData = _filteredData[index];
          return Card(
            child: ListTile(
              title: Text(requesterData.name ?? ''),
              subtitle: _buildSubtitle(requesterData), // Fix this line
            ),
          );
        },
      ),
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
            // Use ElevatedButton or TextButton instead
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                List<RequesterData> allData = await Api.getrequestersdata();
                setState(() {
                  _filteredData = allData
                      .where((data) =>
                          (data.bloodgroup == _selectedBloodGroup ||
                              _selectedBloodGroup == null) &&
                          (data.address?.contains(_selectedLocation ?? '') ??
                              false))
                      .toList();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubtitle(RequesterData requesterData) {
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
}
