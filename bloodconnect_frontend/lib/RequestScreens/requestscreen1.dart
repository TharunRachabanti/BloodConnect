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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showFilterDialog(context);
              },
              child: Text('Filter', style: TextStyle(fontSize: 18)),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _getFilteredUsersStream(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return CardItem(data: data);
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
          title: Text('Filter Options', style: TextStyle(fontSize: 20)),
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
              SizedBox(height: 8),
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
              child: Text('Cancel', style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Search', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }
}

class CardItem extends StatefulWidget {
  final Map<String, dynamic> data;

  const CardItem({required this.data});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(''), // Add the URL for the image
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data['name'] ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text('Blood Group: ${widget.data['bloodGroup'] ?? ''}'),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.location_on, color: Colors.red, size: 20),
                  SizedBox(width: 20),
                  Icon(Icons.phone, color: Colors.green, size: 20),
                ],
              ),
              if (isExpanded) ...[
                SizedBox(height: 16),
                Text(
                  widget.data['address'] ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Age: ${widget.data['age'] ?? ''}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sex: ${widget.data['sex'] ?? ''}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
