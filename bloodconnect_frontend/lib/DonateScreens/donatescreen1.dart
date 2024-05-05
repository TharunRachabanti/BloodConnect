import 'package:flutter/material.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/services/api.dart';

class DonateScreen1 extends StatefulWidget {
  @override
  _DonateScreen1State createState() => _DonateScreen1State();
}

class _DonateScreen1State extends State<DonateScreen1> {
  late Future<List<RequesterData>> _requestDataFuture;
  int expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    _requestDataFuture = Api.getrequestersdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<RequesterData>>(
        future: _requestDataFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<RequesterData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          List<RequesterData> rdata =
              snapshot.data!.where((data) => data.bloodgroup == 'O+').toList();
          if (rdata.isEmpty) {
            return Center(child: Text('No O+ blood group seekers available'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: rdata.length,
            itemBuilder: (BuildContext context, int index) {
              return DonateCard(
                requesterData: rdata[index],
                isExpanded: index == expandedIndex,
                onTap: () {
                  setState(() {
                    expandedIndex = index == expandedIndex ? -1 : index;
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}

class DonateCard extends StatelessWidget {
  final RequesterData requesterData;
  final bool isExpanded;
  final VoidCallback onTap;

  const DonateCard({
    required this.requesterData,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  'https://images.squarespace-cdn.com/content/v1/5811246737c581e3d863f020/1514670194571-9YWHQITTW2PJ2M4RMZFY/Happiest+person+in+the+world%21.jpg',
                ),
              ),
              title: Text(
                requesterData.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                'Blood Group: ${requesterData.bloodgroup ?? ''}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      // Handle map icon press
                    },
                    child: Icon(Icons.location_on, color: Colors.red),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      // Handle phone icon press
                    },
                    child: Icon(Icons.phone, color: Colors.green),
                  ),
                ],
              ),
            ),
            if (isExpanded) ...[
              const Divider(color: Colors.black38),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender: ${requesterData.gender}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Address: ${requesterData.address}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Phone Number: ${requesterData.phonenumber}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Tag: ${requesterData.tag}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Show in Profile: ${requesterData.showInProfile != null ? requesterData.showInProfile.toString() : 'Not Provided'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
