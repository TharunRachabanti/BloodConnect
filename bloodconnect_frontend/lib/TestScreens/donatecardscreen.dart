import 'package:bloodconnect_frontend/models/donatedatamodel.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore for Timestamp

class DonateCardScreen extends StatelessWidget {
  const DonateCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DonateScreenCardScreen"),
      ),
      body: FutureBuilder<List<DonateData>>(
        future: _getDonorData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<DonateData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                DonateData donateData = snapshot.data![index];
                String formattedTimestamp = donateData.timestamp != null
                    ? _formatTimestamp(donateData.timestamp!)
                    : '';
                return Card(
                  child: ListTile(
                    title: Text(donateData.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blood Group: ${donateData.bloodGroup ?? ''}'),
                        Text('Gender: ${donateData.sex ?? ''}'),
                        Text('Address: ${donateData.address ?? ''}'),
                        Text('Age: ${donateData.age ?? ''}'),
                        Text(
                            'Timestamp: $formattedTimestamp'), // Display formatted timestamp
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<DonateData>> _getDonorData() async {
    List<Map<String, dynamic>> firestoreData =
        await Api.getUsersDataFromFirestore();
    List<DonateData> donorDataList = [];
    for (var data in firestoreData) {
      DonateData donorData = DonateData(
        name: data['name'],
        age: data['age'],
        bloodGroup: data['bloodGroup'],
        sex: data['sex'],
        address: data['address'],
        timestamp: data['timestamp'], // Assign timestamp
      );
      donorDataList.add(donorData);
    }
    return donorDataList;
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTimestamp = DateFormat('HHmmssddMMyyyy').format(dateTime);
    return formattedTimestamp;
  }
}
