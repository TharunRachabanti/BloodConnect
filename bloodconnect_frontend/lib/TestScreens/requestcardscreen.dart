import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class RequestCardScreen extends StatelessWidget {
  const RequestCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RequestCardScreen"),
      ),
      body: FutureBuilder(
        future: Api.getrequestersdata(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RequesterData>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<RequesterData> rdata = snapshot.data!
                .where((data) => data.showInProfile == true)
                .toList();

            return ListView.builder(
              itemCount: rdata.length,
              itemBuilder: (BuildContext context, int index) {
                RequesterData requesterData = rdata[index];
                return Card(
                  child: ListTile(
                    title: Text(requesterData.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blood Group: ${requesterData.bloodgroup ?? ''}'),
                        Text('Gender: ${requesterData.gender ?? ''}'),
                        Text('Address: ${requesterData.address ?? ''}'),
                        Text(
                            'Phone Number: ${requesterData.phonenumber ?? ''}'),
                        Text('Tag: ${requesterData.tag ?? ''}'),
                        Text(
                            'Show in Profile: ${requesterData.showInProfile ?? ''}'),
                        Text(
                            'Timestamp: ${requesterData.createdAt != null ? requesterData.createdAt!.toIso8601String() : ''}'),
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
}
