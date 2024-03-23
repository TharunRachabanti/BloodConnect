import 'package:bloodconnect_frontend/DonateScreens/donatescreen1.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen2.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen3.dart';
import 'package:bloodconnect_frontend/homescreen.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/services/api.dart';
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
            FutureBuilder<List<RequesterData>>(
              future: Api.getrequestersdata(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<RequesterData>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                }
                List<RequesterData> rdata = snapshot.data!
                    .where((data) => data.bloodgroup == 'O+')
                    .toList();
                return ListView.builder(
                  itemCount: rdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    RequesterData requesterData = rdata[index];
                    return Card(
                      child: ListTile(
                        title: Text(requesterData.name ?? ''),
                        subtitle:
                            _buildSubtitle(requesterData), // Fix this line
                      ),
                    );
                  },
                );
              },
            ),
            // You can replace this with OtherBloodGroupsScreen() if needed

            OtherBloodGroupsScreen(),
            DonateScreen3(),
          ],
        ),
      ),
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
