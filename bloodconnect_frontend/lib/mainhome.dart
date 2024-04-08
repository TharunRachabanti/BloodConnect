import 'package:flutter/material.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';
import 'package:bloodconnect_frontend/services/api.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData =
        Future.wait([Api.getrequestersdata(), Api.getImageMessages()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          } else {
            final List<dynamic> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  List<RequesterData> rdata =
                      (data[index] as List<RequesterData>)
                          .where((data) => data.showInProfile == true)
                          .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: rdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      RequesterData requesterData = rdata[index];
                      return Card(
                        child: ListTile(
                          title: Text(requesterData.name ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Blood Group: ${requesterData.bloodgroup ?? ''}'),
                              Text('Gender: ${requesterData.gender ?? ''}'),
                              Text('Address: ${requesterData.address ?? ''}'),
                              Text(
                                  'Phone Number: ${requesterData.phonenumber ?? ''}'),
                              Text('Tag: ${requesterData.tag ?? ''}'),
                              Text(
                                  'Show in Profile: ${requesterData.showInProfile ?? ''}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  List<TweetImageModel> tweetImageModels =
                      (data[index] as List<TweetImageModel>);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tweetImageModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      TweetImageModel tweetImageModeldata =
                          tweetImageModels[index];
                      return Card(
                        child: ListTile(
                          title: Text(tweetImageModeldata.Message ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'message: ${tweetImageModeldata.Message ?? ''}'),
                              Image.network(
                                tweetImageModeldata.Imageurl ?? '',
                                width: 200, // Adjust the width as needed
                                height: 200, // Adjust the height as needed
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
