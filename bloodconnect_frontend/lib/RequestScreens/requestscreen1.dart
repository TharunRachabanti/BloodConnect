import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestScreen1 extends StatefulWidget {
  @override
  _RequestScreen1State createState() => _RequestScreen1State();
}

class _RequestScreen1State extends State<RequestScreen1> {
  String bloodGroupFilter = '';
  String locationFilter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donors'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              _showFilterDialog(context);
            },
            child: Text('Filter'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _getFilteredUsersStream(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Age: ${data['age']}'),
                          Text('Blood Group: ${data['bloodGroup']}'),
                          Text('Address: ${data['address']}'),
                          Text('Sex: ${data['sex']}'),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> _getFilteredUsersStream() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Query query = users;

    if (bloodGroupFilter.isNotEmpty) {
      query = query.where('bloodGroup', isEqualTo: bloodGroupFilter);
    }

    if (locationFilter.isNotEmpty) {
      query = query.where('address', isEqualTo: locationFilter);
    }

    return query.snapshots();
  }

  void _showFilterDialog(BuildContext context) {
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
                    bloodGroupFilter = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  setState(() {
                    locationFilter = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
